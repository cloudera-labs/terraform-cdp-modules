# Copyright 2024 Cloudera, Inc. All Rights Reserved.
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

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "vpc_cidr_blocks" {
  value = try(aws_vpc.vpc.cidr_block, null)

  description = "CIDR Block Associations for the VPC"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.igw.id
  description = "The ID of the Internet Gateway"
}

output "default_route_table" {
  value       = aws_vpc.vpc.default_route_table_id
  description = "The ID of the default route table"
}

# ------- Outputs related to TGW Subnets -------
output "tgw_subnet_ids" {
  value       = values(aws_subnet.tgw)[*].id
  description = "The IDs of Transit Gateway subnets"
}

output "tgw_subnets" {
  value       = values(aws_subnet.tgw)
  description = "All details of the Transit Gateway subnets"
}

output "tgw_subnet_route_tables" {
  value       = values(aws_route_table.tgw)[*].id
  description = "List of IDs of the routes tables associated with the Transit Gateway subnets"
}

# ------- Outputs related to Firewall Subnets -------
output "fw_subnet_ids" {
  value       = values(aws_subnet.fw)[*].id
  description = "The IDs of Firewall subnets"
}

output "fw_subnets" {
  value       = values(aws_subnet.fw)
  description = "All details of the Firewall subnets"
}

output "fw_subnet_route_tables" {
  value       = values(aws_route_table.fw)[*].id
  description = "List of IDs of the routes tables associated with the Firewall subnets"
}

# ------- Outputs related to NAT Subnets -------
output "nat_subnet_ids" {
  value       = values(aws_subnet.nat)[*].id
  description = "The IDs of NAT subnets"
}

output "nat_subnets" {
  value       = values(aws_subnet.nat)
  description = "All details of the NAT subnets"
}

output "nat_subnet_route_tables" {
  value       = values(aws_route_table.nat)[*].id
  description = "List of IDs of the routes tables associated with the NAT subnets"
}

output "nat_gateway_ids" {
  value       = aws_nat_gateway.nat_gateway[*].id
  description = "List of IDs of the NAT Gateways"
}
