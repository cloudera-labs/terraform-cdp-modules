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

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "abce3e07-b32d-4b41-8c78-2bcaffe4ea27"
}

# ------- Azure Resource Group -------
module "rmgp" {
  source = "../../../terraform-azure-resource-group"

  resourcegroup_name = "${var.env_prefix}-rg"
  azure_region       = var.azure_region

  tags = merge(var.env_tags, { Name = "${var.env_prefix}-rg" })
}

# ------- Azure VNet and SGs -------
module "ex01_cdp_vnet" {
  source = "../../../terraform-azure-vnet"

  deployment_template = var.deployment_template
  resourcegroup_name  = module.rmgp.resource_group_name
  vnet_name           = "${var.env_prefix}-net"
  vnet_cidr           = "10.10.0.0/16"
  vnet_region         = var.azure_region

  cdp_subnet_prefix       = "${var.env_prefix}-cdp-sbnt"
  gateway_subnet_prefix   = "${var.env_prefix}-gw-sbnt"
  delegated_subnet_prefix = "${var.env_prefix}-delegated-sbnt"

  subnet_count                                  = 1
  cdp_subnet_range                              = 19
  cdp_subnets_private_endpoint_network_policies = "Enabled"

  gateway_subnet_range                              = 24
  gateway_subnets_private_endpoint_network_policies = "Enabled"
  delegated_subnet_range                            = 26

  tags = var.env_tags

  depends_on = [module.rmgp]
}

# ------- Azure Bastion Host Subnet -------
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = module.rmgp.resource_group_name
  virtual_network_name = module.ex01_cdp_vnet.vnet_name
  address_prefixes     = ["10.10.96.0/26"]
}

# ------- Azure Bastion Host -------
module "ex01_bastion" {
  source = "../.."

  bastion_resourcegroup_name = module.rmgp.resource_group_name
  azure_region               = var.azure_region
  tags                       = var.env_tags


  bastion_public_ip_name = "${var.env_prefix}-bastion-pip"
  use_static_public_ip   = true

  bastion_host_name     = "${var.env_prefix}-bastion"
  bastion_ipconfig_name = "${var.env_prefix}-bastion-ipconfig"
  bastion_subnet_id     = azurerm_subnet.bastion_subnet.id

  depends_on = [module.ex01_cdp_vnet]
}
