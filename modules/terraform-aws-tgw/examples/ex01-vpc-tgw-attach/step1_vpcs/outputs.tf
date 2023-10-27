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

output "ex01_cdp_vpc_id" {
  value = module.ex01_cdp_vpc.vpc_id
}
output "ex01_cdp_private_subnet_ids" {
  value = module.ex01_cdp_vpc.private_subnets
}
output "ex01_cdp_public_subnet_ids" {
  value = module.ex01_cdp_vpc.public_subnets
}
output "ex01_cdp_private_route_table_ids" {
  value = module.ex01_cdp_vpc.private_route_tables
}
output "ex01_cdp_public_route_table_ids" {
  value = module.ex01_cdp_vpc.public_route_tables
}


output "ex01_network_vpc_id" {
  value = module.ex01_network_vpc.vpc_id
}
output "ex01_network_private_subnet_ids" {
  value = module.ex01_network_vpc.private_subnets
}
output "ex01_network_public_subnet_ids" {
  value = module.ex01_network_vpc.public_subnets
}
output "ex01_network_private_route_table_ids" {
  value = module.ex01_network_vpc.private_route_tables
}
output "ex01_network_public_route_table_ids" {
  value = module.ex01_network_vpc.public_route_tables
}