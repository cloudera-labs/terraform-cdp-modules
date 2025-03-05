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

data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = var.resourcegroup_name

  depends_on = [azurerm_virtual_network.cdp_vnet]
}

data "azurerm_subnet" "cdp_subnets" {

  for_each = toset(local.cdp_subnet_names)

  name                 = each.value
  virtual_network_name = local.vnet_name
  resource_group_name  = var.resourcegroup_name

  depends_on = [azurerm_subnet.cdp_subnets]
}

data "azurerm_subnet" "gateway_subnets" {

  for_each = toset(local.gateway_subnet_names)

  name                 = each.value
  virtual_network_name = local.vnet_name
  resource_group_name  = var.resourcegroup_name

  depends_on = [azurerm_subnet.gateway_subnets]
}

data "azurerm_subnet" "delegated_subnets" {

  for_each = toset(local.delegated_subnet_names)

  name                 = each.value
  virtual_network_name = local.vnet_name
  resource_group_name  = var.resourcegroup_name

  depends_on = [azurerm_subnet.delegated_subnet]
}