# Copyright 2026 Cloudera, Inc. All Rights Reserved.
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

# ------- Storage Accounts -------
resource "azurerm_storage_account" "cdp_storage_locations" {
  for_each = local.accounts_to_create

  name                = "${each.value}${var.storage_suffix}"
  resource_group_name = var.resource_group_name
  location            = var.location

  public_network_access = var.public_network_access_enabled ? "Enabled" : "Disabled"

  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  is_hns_enabled           = true

  tags = merge(var.tags, { Name = "${each.value}${var.storage_suffix}" })
}

# ------- Network Rules (created accounts only) -------
resource "azurerm_storage_account_network_rules" "cdp_storage_access_rules" {
  for_each = { for k, v in azurerm_storage_account.cdp_storage_locations : k => v
  if var.create_network_rules }

  storage_account_id         = each.value.id
  default_action             = var.network_rules_default_action
  bypass                     = var.network_rules_bypass
  ip_rules                   = var.network_rules_ip_rules
  virtual_network_subnet_ids = var.network_rules_subnet_ids
}

# ------- Storage Containers -------
resource "azurerm_storage_container" "cdp_data_storage" {
  count = var.create_data_storage ? 1 : 0

  name                  = var.data_storage_container
  storage_account_id    = azurerm_storage_account.cdp_storage_locations[local.resolved_data_storage_account].id
  container_access_type = "private"
}

resource "azurerm_storage_container" "cdp_log_storage" {
  count = var.create_log_storage ? 1 : 0

  name                  = var.log_storage_container
  storage_account_id    = azurerm_storage_account.cdp_storage_locations[local.resolved_log_storage_account].id
  container_access_type = "private"
}

resource "azurerm_storage_container" "cdp_backup_storage" {
  count = var.create_backup_storage ? 1 : 0

  name                  = var.backup_storage_container
  storage_account_id    = azurerm_storage_account.cdp_storage_locations[local.resolved_backup_storage_account].id
  container_access_type = "private"
}
