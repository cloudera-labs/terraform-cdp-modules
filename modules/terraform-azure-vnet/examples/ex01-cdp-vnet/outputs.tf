# Copyright 2025 Cloudera, Inc. All Rights Reserved.
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

output "vnet_name" {
  description = "The name of the VNet"
  value       = module.ex01_cdp_vnet.vnet_name
}

output "vnet_id" {
  description = "The ID of the VNet"
  value       = module.ex01_cdp_vnet.vnet_id
}

output "vnet_address_space" {
  description = "The Address Space of the VNet"
  value       = module.ex01_cdp_vnet.vnet_address_space
}

output "vnet_cdp_subnet_ids" {
  description = "List of IDs of subnets for CDP Resources"
  value       = module.ex01_cdp_vnet.vnet_cdp_subnet_ids
}

output "vnet_cdp_subnet_names" {
  description = "Names of the subnets for CDP Resources"
  value       = module.ex01_cdp_vnet.vnet_cdp_subnet_names
}

output "vnet_gateway_subnet_ids" {
  description = "List of IDs of subnets for CDP Gateway"
  value       = module.ex01_cdp_vnet.vnet_gateway_subnet_ids
}

output "vnet_gateway_subnet_names" {
  description = "Names of the subnets for CDP Gateway"
  value       = module.ex01_cdp_vnet.vnet_gateway_subnet_names
}

output "vnet_delegated_subnet_ids" {
  description = "List of IDs of subnets delegated for Private Flexbile Servers"
  value       = module.ex01_cdp_vnet.vnet_delegated_subnet_ids
}

output "vnet_delegated_subnet_names" {
  description = "Names of subnets delegated for Private Flexbile Servers"
  value       = module.ex01_cdp_vnet.vnet_delegated_subnet_names
}

output "nat_gateway_name" {
  description = "The name of the NAT Gateway"
  value       = module.ex01_cdp_vnet.nat_gateway_name
}

output "nat_gateway_id" {
  description = "The id of the NAT Gateway"
  value       = module.ex01_cdp_vnet.nat_gateway_id
}
