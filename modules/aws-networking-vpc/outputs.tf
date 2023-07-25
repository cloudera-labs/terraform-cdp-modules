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

output "aws_vpc_id" {
  value = module.networking_vpc.vpc_id

  description = "AWS VPC ID for Networking"
}

output "aws_default_route_table_id" {
  value = module.networking_vpc.default_route_table_id

  description = "AWS default route table ID for Networking"
}

output "aws_public_route_table_ids" {
  value = module.networking_vpc.public_route_table_ids

  description = "AWS public route table IDs for Networking"
}

output "aws_private_route_table_ids" {
  value = module.networking_vpc.private_route_table_ids

  description = "AWS private route table IDs for Networking"
}

output "aws_public_subnet_ids" {
  value = module.networking_vpc.public_subnets

  description = "AWS public subnet IDs for Networking"
}

output "aws_private_subnet_ids" {
  value = module.networking_vpc.private_subnets

  description = "AWS private subnet IDs for Networking"
}

output "aws_vpc_subnets" {
  value = data.aws_subnets.vpc_subnets

  description = "List of subnets associated with the CDP VPC"
}
