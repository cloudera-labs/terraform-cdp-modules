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

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.cdp_vpc.vpc_id
}

output "default_route_table" {
  description = "The ID of the default route table"
  value       = module.cdp_vpc.default_route_table_id
}

output "public_route_tables" {
  description = "List of IDs of the public route tables"
  value       = module.cdp_vpc.public_route_table_ids
}

output "private_route_tables" {
  description = "List of IDs of the private route tables"
  value       = module.cdp_vpc.private_route_table_ids
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.cdp_vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.cdp_vpc.public_subnets
}