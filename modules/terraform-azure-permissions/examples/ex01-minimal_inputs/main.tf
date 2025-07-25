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

terraform {
  required_version = ">= 1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

}

# ------- Azure Resource Group -------
module "rmgp" {
  source = "../../../terraform-azure-resource-group"

  resourcegroup_name = "${var.env_prefix}-rg"
  azure_region       = var.azure_region

  tags = merge(var.env_tags, { Name = "${var.env_prefix}-rg" })
}


# ------- Azure Storage Containers -------
resource "azurerm_storage_account" "cdp_storage_location" {
  # Create buckets for the unique list of buckets in data and log storage

  name                = "${replace(var.env_prefix, "/[-_]/", "")}stor"
  resource_group_name = module.rmgp.resource_group_name
  location            = var.azure_region

  public_network_access_enabled = false

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true

  tags = merge(var.env_tags, { Name = "${var.env_prefix}-stor" })
}

# Data Storage Objects
resource "azurerm_storage_container" "cdp_data_storage" {

  name                  = "data"
  storage_account_id    = azurerm_storage_account.cdp_storage_location.id
  container_access_type = "private"

}

# Log Storage Objects
resource "azurerm_storage_container" "cdp_log_storage" {

  name                  = "log"
  storage_account_id    = azurerm_storage_account.cdp_storage_location.id
  container_access_type = "private"

}

# Backup Storage Object
resource "azurerm_storage_container" "cdp_backup_storage" {

  name                  = "backup"
  storage_account_id    = azurerm_storage_account.cdp_storage_location.id
  container_access_type = "private"

}

# ------- Azure Permissions -------
module "ex01_azure_permissions" {
  source = "../.."

  azure_region        = var.azure_region
  resource_group_name = module.rmgp.resource_group_name

  idbroker_managed_identity_name = "${var.env_prefix}-idbroker-identity"
  idbroker_role_assignments      = var.idbroker_role_assignments

  datalake_admin_managed_identity_name             = "${var.env_prefix}-datalake-admin-identity"
  datalake_admin_data_container_role_assignments   = var.datalake_admin_data_container_role_assignments
  datalake_admin_log_container_role_assignments    = var.datalake_admin_log_container_role_assignments
  datalake_admin_backup_container_role_assignments = var.datalake_admin_backup_container_role_assignments

  data_storage_container_id   = azurerm_storage_container.cdp_data_storage.id
  log_storage_container_id    = azurerm_storage_container.cdp_log_storage.id
  backup_storage_container_id = azurerm_storage_container.cdp_backup_storage.id

  log_data_access_managed_identity_name = "${var.env_prefix}-log-data-access-identity"
  log_data_access_role_assignments      = var.log_data_access_role_assignments

  ranger_audit_data_access_managed_identity_name = "${var.env_prefix}-ranger-audit-identity"
  ranger_audit_data_container_role_assignments   = var.ranger_audit_data_container_role_assignments
  ranger_audit_log_container_role_assignments    = var.ranger_audit_log_container_role_assignments
  ranger_audit_backup_container_role_assignments = var.ranger_audit_backup_container_role_assignments

  enable_raz                   = var.enable_raz
  data_storage_account_id      = var.enable_raz ? azurerm_storage_account.cdp_storage_location.id : null
  raz_managed_identity_name    = "${var.env_prefix}-raz-identity"
  raz_storage_role_assignments = var.raz_storage_role_assignments

  depends_on = [
    azurerm_storage_container.cdp_data_storage,
    azurerm_storage_container.cdp_log_storage,
    azurerm_storage_container.cdp_backup_storage,
    module.rmgp
  ]
}
