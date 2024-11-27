# Copyright 2024 Cloudera, Inc. All Rights Reserved.
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
}

# ------- Azure Resource Group -------
resource "azurerm_resource_group" "rmgp" {

  name     = "${var.env_prefix}-rmgp"
  location = var.azure_region

  tags = merge(var.env_tags, { Name = "${var.env_prefix}-rmgp" })
}

# ------- Azure Storage Account -------
resource "azurerm_storage_account" "storage_locations" {
  # Create buckets for the unique list of buckets in data and log storage
  for_each = toset(concat([replace("${var.env_prefix}data", "/[-_]/", "")], [replace("${var.env_prefix}logs", "/[-_]/", "")], [replace("${var.env_prefix}backups", "/[-_]/", "")])
  )

  name                = each.value
  resource_group_name = azurerm_resource_group.rmgp.name
  location            = var.azure_region

  public_network_access_enabled = false

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true

  tags = merge(var.env_tags, { Name = "${each.value}" })
}

# ------- Azure VNet -------
module "ex01_vnet" {
  source = "../../../terraform-cdp-azure-pre-reqs/modules/vnet"

  vnet_name           = "${var.env_prefix}-net"
  resourcegroup_name  = azurerm_resource_group.rmgp.name
  env_prefix          = var.env_prefix
  vnet_region         = var.azure_region
  deployment_template = var.deployment_template

  vnet_cidr              = "10.10.0.0/16"
  subnet_count           = 3
  cdp_subnet_range       = 19
  gateway_subnet_range   = 24
  delegated_subnet_range = 26

  cdp_subnets_private_endpoint_network_policies     = "Enabled"
  gateway_subnets_private_endpoint_network_policies = "Enabled"

  tags = var.env_tags

}

# ------- Azure Private Endpoints -------
module "ex01_private_endpoints" {
  source = "../.."

  resourcegroup_name = azurerm_resource_group.rmgp.name
  vnet_name          = module.ex01_vnet.vnet_name

  azure_region = var.azure_region

  tags = var.env_tags

  private_endpoint_prefix              = var.env_prefix
  private_endpoint_storage_account_ids = values(azurerm_storage_account.storage_locations)[*].id
  private_endpoint_target_subnet_ids   = module.ex01_vnet.vnet_cdp_subnet_ids

  depends_on = [module.ex01_vnet]
}
