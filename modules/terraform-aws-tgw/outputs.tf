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

# TGW

output "transit_gateway_id" {
  description = "Transit Gateway identifier"
  value       = aws_ec2_transit_gateway.tgw.id
}

output "transit_gateway_arn" {
  description = "Transit Gateway Amazon Resource Name (ARN)"
  value       = aws_ec2_transit_gateway.tgw.arn
}

output "transit_gateway_association_default_route_table_id" {
  description = "ID of the default association route table"
  value       = aws_ec2_transit_gateway.tgw.association_default_route_table_id
}

output "transit_gateway_propagation_default_route_table_id" {
  description = "ID of the default propagation route table"
  value       = aws_ec2_transit_gateway.tgw.propagation_default_route_table_id
}

# VPC Attachment

output "transit_gateway_vpc_attachment_ids" {
  description = "List of Transit Gateway VPC Attachment identifiers"
  value       = [for k, v in aws_ec2_transit_gateway_vpc_attachment.tgw_vpc_attach : v.id]
}

output "transit_gateway_vpc_attachment_details" {
  description = "Map of Transit Gateway VPC Attachment attributes"
  value       = aws_ec2_transit_gateway_vpc_attachment.tgw_vpc_attach
}

# TGW Route Tables
output "transit_gateway_route_table_ids" {
  description = "List of Transit Gateway Route Tables"
  value       = [for k, v in aws_ec2_transit_gateway_route_table.tgw_rt : v.id]
}

output "transit_gateway_route_table_details" {
  description = "Map of Transit Gateway Route Table attributes"
  value       = aws_ec2_transit_gateway_route_table.tgw_rt
}
