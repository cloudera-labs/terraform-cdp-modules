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
# 

# ------- Default Security Group -------
resource "aws_security_group" "cdp_default_sg" {

  count = local.create_default_security_group ? 1 : 0

  vpc_id      = var.vpc_id
  name        = var.default_security_group_name
  description = var.default_security_group_name
  tags        = merge(var.tags, { Name = var.default_security_group_name })
}

# Create self reference ingress rule to allow communication within the security group
resource "aws_vpc_security_group_ingress_rule" "cdp_default_sg_ingress_self" {

  count = local.create_default_security_group ? 1 : 0

  security_group_id            = aws_security_group.cdp_default_sg[0].id
  description                  = "Self ingress rule for ${var.default_security_group_name}"
  referenced_security_group_id = aws_security_group.cdp_default_sg[0].id
  ip_protocol                  = "-1"

  tags = merge(var.tags, { Name = var.default_security_group_name })
}

# Create security group rules for VPC CIDR list
resource "aws_vpc_security_group_ingress_rule" "cdp_default_vpc_sg_ingress" {

  count = local.create_default_security_group ? 1 : 0

  security_group_id = aws_security_group.cdp_default_sg[0].id
  description       = "Inter VPC CIDR ingress rule for ${var.default_security_group_name}"
  cidr_ipv4         = var.ingress_vpc_cidr
  ip_protocol       = "-1"

  tags = merge(var.tags, { Name = var.default_security_group_name })
}

# Create security group rules for specified extra list of ingress rules - direct CIDR method
resource "aws_vpc_security_group_ingress_rule" "cdp_default_extra_sg_ingress" {

  count = local.create_default_security_group && !var.use_prefix_list_for_ingress ? length(local.security_group_rules_extra_ingress) : 0

  security_group_id = aws_security_group.cdp_default_sg[0].id
  description       = "Extra CIDR ingress rule for ${var.default_security_group_name}"
  cidr_ipv4         = tolist(local.security_group_rules_extra_ingress)[count.index].cidr
  from_port         = try(tolist(local.security_group_rules_extra_ingress)[count.index].port, null)
  to_port           = try(tolist(local.security_group_rules_extra_ingress)[count.index].port, null)
  ip_protocol       = tolist(local.security_group_rules_extra_ingress)[count.index].protocol

  tags = merge(var.tags, { Name = var.default_security_group_name })
}

# Create security group rules using prefix list method
resource "aws_vpc_security_group_ingress_rule" "cdp_default_extra_sg_ingress_pl" {
  count = local.create_default_security_group && var.use_prefix_list_for_ingress ? length(var.ingress_extra_cidrs_and_ports.ports) : 0

  security_group_id = aws_security_group.cdp_default_sg[0].id
  description       = "Extra CIDRs prefix list ingress rule for ${var.default_security_group_name}"
  prefix_list_id    = aws_ec2_managed_prefix_list.cdp_prefix_list[0].id
  from_port         = tolist(var.ingress_extra_cidrs_and_ports.ports)[count.index]
  to_port           = tolist(var.ingress_extra_cidrs_and_ports.ports)[count.index]
  ip_protocol       = "tcp"
  tags              = merge(var.tags, { Name = var.default_security_group_name })
}

# Terraform removes the default ALLOW ALL egress. Let's recreate this
resource "aws_vpc_security_group_egress_rule" "cdp_default_sg_egress" {

  count = local.create_default_security_group ? length(var.cdp_default_sg_egress_cidrs) : 0

  security_group_id = aws_security_group.cdp_default_sg[0].id
  description       = "All traffic egress for ${var.default_security_group_name}"
  ip_protocol       = -1
  cidr_ipv4         = var.cdp_default_sg_egress_cidrs[count.index] #tfsec:ignore:aws-ec2-no-public-egress-sgr #tfsec:ignore:aws-vpc-no-public-egress-sgr

  tags = merge(var.tags, { Name = var.default_security_group_name })
}

# ------- Knox Security Groups -------
resource "aws_security_group" "cdp_knox_sg" {

  count = local.create_knox_security_group ? 1 : 0

  vpc_id      = var.vpc_id
  name        = var.knox_security_group_name
  description = var.knox_security_group_name
  tags        = merge(var.tags, { Name = var.knox_security_group_name })
}


# Create self reference ingress rule to allow communication within the security group.
resource "aws_vpc_security_group_ingress_rule" "cdp_knox_sg_ingress_self" {

  count = local.create_knox_security_group ? 1 : 0

  security_group_id            = aws_security_group.cdp_knox_sg[0].id
  description                  = "Self ingress rule for ${var.knox_security_group_name}"
  referenced_security_group_id = aws_security_group.cdp_knox_sg[0].id
  ip_protocol                  = "-1"

  tags = merge(var.tags, { Name = var.knox_security_group_name })
}

# Create security group rules for VPC CIDR list
resource "aws_vpc_security_group_ingress_rule" "cdp_knox_vpc_sg_ingress" {

  count = local.create_knox_security_group ? 1 : 0

  security_group_id = aws_security_group.cdp_knox_sg[0].id
  description       = "Inter VPC CIDR ingress rule for ${var.knox_security_group_name}"
  cidr_ipv4         = var.ingress_vpc_cidr
  ip_protocol       = "-1"

  tags = merge(var.tags, { Name = var.knox_security_group_name })
}

# Create security group rules for specified extra list of ingress rules - direct CIDR method
resource "aws_vpc_security_group_ingress_rule" "cdp_knox_extra_sg_ingress" {

  count = local.create_knox_security_group && !var.use_prefix_list_for_ingress ? length(local.security_group_rules_extra_ingress) : 0

  security_group_id = aws_security_group.cdp_knox_sg[0].id
  description       = "Extra CIDR ingress rule for ${var.knox_security_group_name}"
  cidr_ipv4         = tolist(local.security_group_rules_extra_ingress)[count.index].cidr
  from_port         = try(tolist(local.security_group_rules_extra_ingress)[count.index].port, null)
  to_port           = try(tolist(local.security_group_rules_extra_ingress)[count.index].port, null)
  ip_protocol       = tolist(local.security_group_rules_extra_ingress)[count.index].protocol

  tags = merge(var.tags, { Name = var.knox_security_group_name })
}

# Use existing prefix list rule for Knox with conditional
resource "aws_vpc_security_group_ingress_rule" "cdp_knox_extra_sg_ingress_pl" {
  count = local.create_knox_security_group && var.use_prefix_list_for_ingress ? length(var.ingress_extra_cidrs_and_ports.ports) : 0

  security_group_id = aws_security_group.cdp_knox_sg[0].id
  description       = "Extra CIDRs prefix list ingress rule for ${var.knox_security_group_name}"
  prefix_list_id    = aws_ec2_managed_prefix_list.cdp_prefix_list[0].id
  from_port         = tolist(var.ingress_extra_cidrs_and_ports.ports)[count.index]
  to_port           = tolist(var.ingress_extra_cidrs_and_ports.ports)[count.index]
  ip_protocol       = "tcp"
  tags              = merge(var.tags, { Name = var.knox_security_group_name })
}

# Terraform removes the default ALLOW ALL egress. Let's recreate this
resource "aws_vpc_security_group_egress_rule" "cdp_knox_sg_egress" {

  count = local.create_knox_security_group ? length(var.cdp_knox_sg_egress_cidrs) : 0

  security_group_id = aws_security_group.cdp_knox_sg[0].id
  description       = "All traffic egress for ${var.knox_security_group_name}"
  ip_protocol       = -1
  cidr_ipv4         = var.cdp_knox_sg_egress_cidrs[count.index] #tfsec:ignore:aws-ec2-no-public-egress-sgr #tfsec:ignore:aws-vpc-no-public-egress-sgr

  tags = merge(var.tags, { Name = var.knox_security_group_name })
}


# Create prefix list for extra ingress rules if specified and prefix list option is enabled
resource "aws_ec2_managed_prefix_list" "cdp_prefix_list" {
  count = var.use_prefix_list_for_ingress ? 1 : 0

  name           = var.prefix_list_name
  address_family = "IPv4"
  max_entries    = length(var.ingress_extra_cidrs_and_ports.cidrs)
}

resource "aws_ec2_managed_prefix_list_entry" "cdp_prefix_list_entry" {
  for_each = var.use_prefix_list_for_ingress ? { for idx, cidr in var.ingress_extra_cidrs_and_ports.cidrs : idx => cidr } : {}

  prefix_list_id = aws_ec2_managed_prefix_list.cdp_prefix_list[0].id
  cidr           = each.value
  description    = "${var.prefix_list_name}-ingress"

}
