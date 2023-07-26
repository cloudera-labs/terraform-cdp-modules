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


# VPC Endpoint SG
resource "aws_security_group" "proxy_sg" {

  count = var.create_proxy_sg ? 1 : 0

  vpc_id      = var.vpc_id
  name        = local.security_group_proxy_name
  description = local.security_group_proxy_name
  tags        = merge(local.env_tags, { Name = local.security_group_proxy_name })
}

# Create ingress SG rule
resource "aws_security_group_rule" "proxy_ingress" {

  for_each = { for k, v in var.ingress_rules : k => v
    if var.create_proxy_sg
  }

  security_group_id = aws_security_group.proxy_sg[0].id
  type              = "ingress"
  description       = "Ingress rules for Default CDP Security Group"

  cidr_blocks = each.value.cidrs
  from_port   = each.value.from_port
  to_port     = coalesce(each.value.to_port, each.value.from_port)
  protocol    = each.value.protocol

}

# Create egress SG rule
resource "aws_security_group_rule" "proxy_egress" {

  for_each = { for k, v in var.egress_rules : k => v
    if var.create_proxy_sg
  }

  security_group_id = aws_security_group.proxy_sg[0].id
  type              = "egress"
  description       = "Egress rules for Default CDP Security Group"

  cidr_blocks = each.value.cidrs
  from_port   = each.value.from_port
  to_port     = coalesce(each.value.to_port, each.value.from_port)
  protocol    = each.value.protocol

}

resource "aws_instance" "proxy" {

  ami           = local.aws_ami
  instance_type = var.aws_instance_type
  key_name      = var.aws_keypair_name

  subnet_id = var.subnet_id
  vpc_security_group_ids = [
    local.proxy_security_group_id
  ]

  source_dest_check           = false # need to stop Source/destination check for the proxy instance
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/files/user-data-squid-proxy.sh", {})

  tags = merge(local.env_tags, { Name = "${var.env_prefix}-proxy" })
}

# TODO: Review if this is best place to create the route for eni
resource "aws_route" "vpc_tgw_route" {
  for_each = { 
    for k,v in local.route_tables_to_update: k => v
    }

  route_table_id         = each.value.route_table
  destination_cidr_block = each.value.destination_cidr_block
  network_interface_id   = aws_instance.proxy.primary_network_interface_id
}

