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

# ------- Transit Gateway & VPC Attachments -------
# Create Transit Gateway
resource "aws_ec2_transit_gateway" "tgw" {
  description = "Transit Gateway for ${var.tgw_name}"

  dns_support      = var.tgw_dns_support
  vpn_ecmp_support = var.tgw_vpn_ecmp_support

  default_route_table_association = var.tgw_default_route_table_association
  default_route_table_propagation = var.tgw_default_route_table_propagation

  tags = merge(var.env_tags, { Name = var.tgw_name })
}

# Attach specified VPCs to TGW
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_vpc_attach" {

  for_each = var.vpc_attachments

  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = each.value.vpc_id
  subnet_ids         = each.value.subnet_ids

  transit_gateway_default_route_table_association = try(each.value.tgw_default_route_table_association, var.vpc_attach_tgw_default_route_table_association)
  transit_gateway_default_route_table_propagation = try(each.value.tgw_default_route_table_propagation, var.vpc_attach_tgw_default_route_table_propagation)

  dns_support = try(each.value.dns_support, var.vpc_attach_dns_support)

  tags = merge(var.env_tags, { Name = "${var.tgw_name}-attach-${each.key}" })
}

# ------- Transit Gateway Route Table -------
# Transit Gateway Route Table
resource "aws_ec2_transit_gateway_route_table" "tgw_rt" {

  for_each = {
    for k, v in var.vpc_attachments : k => v
    if try(v.create_tgw_route_table, false) == true
  }

  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = merge(var.env_tags, { Name = "${var.tgw_name}-rtb-${each.key}" })
}

# Create Association to route traffic.
resource "aws_ec2_transit_gateway_route_table_association" "tgw_rt_assoc" {

  for_each = {
    for k, v in var.vpc_attachments : k => v
    if try(v.create_tgw_route_table, false) == true
  }

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_vpc_attach[each.key].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt[each.key].id
}

# Create Propagations to route traffic.
resource "aws_ec2_transit_gateway_route_table_propagation" "tgw_rt_propag" {

  for_each = {
    for k, v in var.vpc_attachments : k => v
    if try(v.create_tgw_route_table, false) == true
  }

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_vpc_attach[each.value.rt_propagation_key].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt[each.key].id
}

# Create Static Transit Gateway Route Table Entries
resource "aws_ec2_transit_gateway_route" "tgw_routes" {

  for_each = {
    for k, v in local.vpc_attachment_with_tgw_routes : k => v
    if try(v.create_tgw_route_table, true) == true
  }

  destination_cidr_block        = each.value.destination_cidr_block
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw_vpc_attach[each.value.route_attachement_key].id

  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt[each.value.route_table_key].id
}

# ------- VPC Route Table -------
# VPC Route Tables entries
resource "aws_route" "vpc_tgw_route" {
  for_each = {
    for k, v in local.vpc_attachment_with_vpc_routes : k => v
    if try(v.create_vpc_routes, false) == true
  }

  route_table_id         = each.value.route_table
  destination_cidr_block = each.value.destination_cidr_block
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

# output "vpc_attachment_with_vpc_routes" {
#   value = local.vpc_attachment_with_vpc_routes
# }