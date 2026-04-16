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

# Access information about Azure Subscription
data "azurerm_subscription" "current" {}

# Find details about the log storage account
data "azurerm_storage_account" "log_storage_account" {
  name                = var.azure_log_storage_account_name
  resource_group_name = var.azure_resource_group_name
}

data "azurerm_storage_container" "log_storage_container" {
  name               = var.azure_log_storage_container_name
  storage_account_id = data.azurerm_storage_account.log_storage_account.id
}
