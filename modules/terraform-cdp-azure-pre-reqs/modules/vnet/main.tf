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


# ------- VNet -------
resource "azurerm_virtual_network" "cdp_vnet" {
  name                = var.vnet_name
  location            = var.vnet_region
  resource_group_name = var.resourcegroup_name
  address_space       = [var.vnet_cidr]
  dns_servers         = []

  tags = merge(var.tags, { Name = "${var.env_prefix}-net" })
}

# ------- Subnets -------
# Azure VNet Public Subnets
resource "azurerm_subnet" "cdp_subnets" {

  for_each = { for idx, subnet in local.subnets : idx => subnet }

  virtual_network_name = azurerm_virtual_network.cdp_vnet.name
  resource_group_name  = var.resourcegroup_name
  name                 = each.value.name
  address_prefixes     = [each.value.cidr]

  service_endpoints                         = ["Microsoft.Sql", "Microsoft.Storage"]
  private_endpoint_network_policies_enabled = true

}
