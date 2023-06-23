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

output "vnet_id" {
  description = "The ID of the VNet"
  value       = azurerm_virtual_network.cdp_vnet.id
}

output "vnet_name" {
  description = "The ID of the VNet"
  value       = azurerm_virtual_network.cdp_vnet.name
}

output "vnet_subnet_ids" {
  description = "List of IDs of subnets"
  value       = values(azurerm_subnet.cdp_subnets)[*].id
}

output "vnet_subnet_names" {
  description = "Names of the subnets"
  value       = values(azurerm_subnet.cdp_subnets)[*].name
}