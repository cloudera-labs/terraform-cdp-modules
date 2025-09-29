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

# ------- Azure Managed Identities & Role Asignment - IDBroker -------

# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_idbroker" {
  location            = var.azure_region
  name                = var.idbroker_managed_identity_name
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, { Name = var.idbroker_managed_identity_name })
}

# Assign the required roles to the managed identity
resource "azurerm_role_assignment" "cdp_idbroker_assign" {

  for_each = { for idx, role in var.idbroker_role_assignments : idx => role }

  scope                = data.azurerm_subscription.current.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_idbroker.principal_id

  description = each.value.description
}

# ------- Azure Managed Identities & Role Asignment - Datalake Admin -------

# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_datalake_admin" {
  location            = var.azure_region
  name                = var.datalake_admin_managed_identity_name
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, { Name = var.datalake_admin_managed_identity_name })
}

# Assign the required roles to the managed identity for Data storage container
resource "azurerm_role_assignment" "cdp_datalake_admin_data_container_assign" {

  for_each = { for idx, role in var.datalake_admin_data_container_role_assignments : idx => role }

  scope                = var.data_storage_container_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_datalake_admin.principal_id

  description = each.value.description
}

# Assign the required roles to the managed identity for Log storage container
resource "azurerm_role_assignment" "cdp_datalake_admin_log_container_assign" {

  for_each = { for idx, role in var.datalake_admin_log_container_role_assignments : idx => role }

  scope                = var.log_storage_container_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_datalake_admin.principal_id

  description = each.value.description
}

# Assign the required roles to the managed identity for Backup storage container
resource "azurerm_role_assignment" "cdp_datalake_admin_backup_container_assign" {

  for_each = { for idx, role in var.datalake_admin_backup_container_role_assignments : idx => role }

  scope                = var.backup_storage_container_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_datalake_admin.principal_id

  description = each.value.description
}

# ------- Azure Managed Identities & Role Asignment - Log Data Access -------

# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_log_data_access" {
  location            = var.azure_region
  name                = var.log_data_access_managed_identity_name
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, { Name = var.log_data_access_managed_identity_name })
}

# Assign the required roles to the managed identity
resource "azurerm_role_assignment" "cdp_log_data_access_log_container_assign" {

  for_each = { for idx, role in var.log_data_access_role_assignments : idx => role }

  scope                = var.log_storage_container_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_log_data_access.principal_id

  description = each.value.description
}

resource "azurerm_role_assignment" "cdp_log_data_access_backup_container_assign" {

  for_each = { for idx, role in var.log_data_access_role_assignments : idx => role }

  scope                = var.backup_storage_container_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_log_data_access.principal_id

  description = each.value.description
}

# ------- Azure Managed Identities & Role Asignment - Ranger Audit -------

# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_ranger_audit_data_access" {
  location            = var.azure_region
  name                = var.ranger_audit_data_access_managed_identity_name
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, { Name = var.ranger_audit_data_access_managed_identity_name })
}

# Assign the required roles to the managed identity
resource "azurerm_role_assignment" "cdp_ranger_audit_data_container_assign" {

  for_each = { for idx, role in var.ranger_audit_data_container_role_assignments : idx => role }

  scope                = var.data_storage_container_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_ranger_audit_data_access.principal_id

  description = each.value.description
}

resource "azurerm_role_assignment" "cdp_ranger_audit_log_container_assign" {

  for_each = { for idx, role in var.ranger_audit_log_container_role_assignments : idx => role }

  scope                = var.log_storage_container_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_ranger_audit_data_access.principal_id

  description = each.value.description
}

resource "azurerm_role_assignment" "cdp_ranger_audit_backup_container_assign" {

  for_each = { for idx, role in var.ranger_audit_backup_container_role_assignments : idx => role }

  scope                = var.backup_storage_container_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_ranger_audit_data_access.principal_id

  description = each.value.description
}

# ------- Azure Managed Identities & Role Asignment - RAZ -------

# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_raz" {

  count = var.enable_raz ? 1 : 0

  location            = var.azure_region
  name                = var.raz_managed_identity_name
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, { Name = var.raz_managed_identity_name })
}

# Assign the required roles to the managed identity
resource "azurerm_role_assignment" "cdp_raz_data_storage_assign" {
  count = var.enable_raz ? length(var.raz_storage_role_assignments) : 0

  scope                = var.data_storage_account_id
  role_definition_name = var.raz_storage_role_assignments[count.index].role
  principal_id         = azurerm_user_assigned_identity.cdp_raz[0].principal_id

  description = var.raz_storage_role_assignments[count.index].description
}
