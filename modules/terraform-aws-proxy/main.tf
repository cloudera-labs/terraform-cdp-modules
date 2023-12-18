# Copyright 2023 Cloudera, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ------- Networking - Security Group and Security Group rules -------
# Security Group for proxy
resource "aws_security_group" "proxy_sg" {

  count = var.create_proxy_sg ? 1 : 0

  vpc_id      = var.vpc_id
  name        = var.proxy_security_group_name
  description = var.proxy_security_group_name
  tags        = merge(var.env_tags, { Name = var.proxy_security_group_name })
}

# Create ingress SG rule
resource "aws_security_group_rule" "proxy_ingress" {

  for_each = { for k, v in var.ingress_rules : k => v
    if var.create_proxy_sg
  }

  security_group_id = aws_security_group.proxy_sg[0].id
  type              = "ingress"
  description       = "Ingress rules for ${var.proxy_security_group_name} Proxy Security Group"

  cidr_blocks = each.value.cidrs
  from_port   = each.value.from_port
  to_port     = coalesce(each.value.to_port, each.value.from_port)
  protocol    = each.value.protocol

}

# Access from NLB to Proxy VMs within the VPC
resource "aws_security_group_rule" "proxy_lb_ingress" {

  count = var.create_proxy_sg ? 1 : 0

  security_group_id = aws_security_group.proxy_sg[0].id
  type              = "ingress"
  description       = "Allow traffic from NLB to Proxy VMs in ${var.proxy_security_group_name} Proxy Security Group"

  cidr_blocks = data.aws_vpc.proxy_vpc.cidr_block_associations[*].cidr_block
  from_port   = var.proxy_port
  to_port     = var.proxy_port
  protocol    = "TCP"
}

# Create egress SG rule
resource "aws_security_group_rule" "proxy_egress" {

  for_each = { for k, v in var.egress_rules : k => v
    if var.create_proxy_sg
  }

  security_group_id = aws_security_group.proxy_sg[0].id
  type              = "egress"
  description       = "Egress rules for ${var.proxy_security_group_name} Proxy Security Group"

  cidr_blocks = each.value.cidrs #tfsec:ignore:aws-ec2-no-public-egress-sgr #tfsec:ignore:aws-vpc-no-public-egress-sgr
  from_port   = each.value.from_port
  to_port     = coalesce(each.value.to_port, each.value.from_port)
  protocol    = each.value.protocol

}

# -------  Proxy launch template and Auto-Scaling Groups -------
resource "aws_launch_template" "proxy_lt" {

  name = var.proxy_launch_template_name

  image_id      = local.proxy_aws_ami
  instance_type = var.proxy_aws_instance_type
  key_name      = var.proxy_aws_keypair_name

  user_data = base64encode(templatefile(local.proxy_launch_template_user_data_file, {
    proxy_port = var.proxy_port
    whitelist_txt = templatefile(local.proxy_whitelist_file, {
      aws_region = local.aws_region
    cdp_region = var.cdp_region })
  }))

  network_interfaces {
    associate_public_ip_address = var.enable_proxy_public_ip
    security_groups             = [local.proxy_security_group_id]
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = var.env_tags

}

resource "aws_autoscaling_group" "proxy_asg" {
  name             = var.proxy_autoscaling_group_name
  min_size         = var.autoscaling_group_scaling.min_size
  max_size         = var.autoscaling_group_scaling.max_size
  desired_capacity = var.autoscaling_group_scaling.desired_capacity

  target_group_arns = [aws_lb_target_group.proxy_tg.arn]

  vpc_zone_identifier = var.proxy_subnet_ids

  launch_template {
    id      = aws_launch_template.proxy_lt.id
    version = "$Latest"
  }

  dynamic "tag" {
    for_each = merge(var.env_tags, { Name = "${var.proxy_autoscaling_group_name}-proxy" })
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

}

# ------- Internal Network Load Balancer -------

resource "aws_lb" "proxy_lb" {
  name               = var.network_load_balancer_name
  internal           = true
  load_balancer_type = "network"
  subnets            = var.lb_subnet_ids

  tags = var.env_tags
}

resource "aws_lb_listener" "proxy_lb_listener" {
  load_balancer_arn = aws_lb.proxy_lb.arn
  port              = var.proxy_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.proxy_tg.arn
  }

  tags = var.env_tags
}

# Target groups are essentially the end point of the LB
resource "aws_lb_target_group" "proxy_tg" {
  name        = var.target_group_proxy_name
  target_type = "instance"
  port        = var.proxy_port
  protocol    = "TCP"
  vpc_id      = var.vpc_id

  # TODO: Review health checks on the TG

  tags = var.env_tags
}

# Now we have a target group we need to assign something to it. This is done through target group attachments
resource "aws_autoscaling_attachment" "proxy_asg_tg_attach" {
  autoscaling_group_name = aws_autoscaling_group.proxy_asg.id
  lb_target_group_arn    = aws_lb_target_group.proxy_tg.arn
}


# ------- Route Table update -------
# Update the route tables to point to eni of NLB
resource "aws_route" "vpc_tgw_route" {
  for_each = {
    for k, v in local.route_tables_to_update : k => v
  }

  route_table_id         = each.value.route_table
  destination_cidr_block = each.value.destination_cidr_block
  network_interface_id   = local.route_table_to_lb_eni_assoc[each.value.route_table].eni
}
