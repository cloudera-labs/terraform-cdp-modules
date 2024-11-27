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

# Access information about Azure Subscription
data "azurerm_subscription" "current" {}

# Get the configuration of the AzureAD provider
data "azuread_client_config" "current" {}

# Find details of the Azure Resource group
data "azurerm_resource_group" "cdp_rmgp" {
  name = local.cdp_resourcegroup_name

  depends_on = [azurerm_resource_group.cdp_rmgp]
}

data "azurerm_virtual_network" "cdp_vnet" {
  name                = local.cdp_vnet_name
  resource_group_name = local.cdp_resourcegroup_name

  depends_on = [module.azure_cdp_vnet]
}

data "azurerm_subnet" "cdp_subnets" {

  for_each = toset(local.cdp_subnet_names)

  name                 = each.value
  virtual_network_name = local.vnet_name
  resource_group_name  = local.resourcegroup_name

  depends_on = [module.azure_cdp_vnet]
}
