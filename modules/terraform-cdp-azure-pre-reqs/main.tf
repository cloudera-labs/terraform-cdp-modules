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

# ------- Azure Resource Group -------
resource "azurerm_resource_group" "cdp_rmgp" {
  name     = local.resourcegroup_name
  location = var.azure_region

  tags     = merge(local.env_tags, { Name = local.resourcegroup_name })  
}

# ------- VPC -------
resource "azurerm_virtual_network" "example" {
  name                = local.vpc_name
  location            = azurerm_resource_group.cdp_rmgp.location
  resource_group_name = azurerm_resource_group.cdp_rmgp.name
  address_space       = [ var.vpc_cidr ]
  dns_servers         = []
  
  tags = merge(local.env_tags, { Name = local.vpc_name })
}
