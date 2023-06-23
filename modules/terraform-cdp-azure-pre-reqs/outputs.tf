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

output "azure_subscription_id" {
  value = data.azurerm_subscription.current.subscription_id

  description = "Subscription ID where the Azure pre-reqs are created"
}

output "azure_tenant_id" {
  value = data.azurerm_subscription.current.tenant_id

  description = "Tenant ID where the Azure pre-reqs are created"
}

output "azure_resource_group_name" {
  value = azurerm_resource_group.cdp_rmgp.name

  description = "Azure Resource Group Name"
}

output "azure_vnet_name" {
  value = local.cdp_vnet_name

  description = "Azure Virtual Network Name"
}

output "azure_subnet_names" {
  value = local.cdp_subnet_names

  description = "Azure Virtual Subnet Names"
}

output "azure_security_group_default_uri" {
  value = azurerm_network_security_group.cdp_default_sg.id

  description = "Azure Default Security Group URI"
}

output "azure_security_group_knox_uri" {
  value = azurerm_network_security_group.cdp_knox_sg.id

  description = "Azure Knox Security Group URI"
}

output "azure_data_storage_location" {
  value = "abfs://${azurerm_storage_container.cdp_data_storage.name}@${azurerm_storage_container.cdp_data_storage.storage_account_name}.dfs.core.windows.net"

  description = "Azure data storage location"

}

output "azure_log_storage_location" {
  value = "abfs://${azurerm_storage_container.cdp_log_storage.name}@${azurerm_storage_container.cdp_log_storage.storage_account_name}.dfs.core.windows.net"

  description = "Azure log storage location"

}

output "azure_backup_storage_location" {
  value = "abfs://${azurerm_storage_container.cdp_backup_storage.name}@${azurerm_storage_container.cdp_backup_storage.storage_account_name}.dfs.core.windows.net"

  description = "Azure backup storage location"

}

output "azure_xaccount_app_uuid" {
  value = azuread_application.cdp_xaccount_app.application_id

  description = "UUID for the Azure AD Cross Account Application"

}

output "azure_xaccount_app_pword" {
  value = azuread_application_password.cdp_xaccount_app_password.value

  description = "Password for the Azure AD Cross Account Application"

  sensitive = true
}

output "azure_idbroker_identity_id" {
  value = azurerm_user_assigned_identity.cdp_idbroker.id

  description = "IDBroker Managed Identity ID"
}

output "azure_datalakeadmin_identity_id" {
  value = azurerm_user_assigned_identity.cdp_datalake_admin.id

  description = "Datalake Admin Managed Identity ID"
}

output "azure_ranger_audit_identity_id" {
  value = azurerm_user_assigned_identity.cdp_ranger_audit_data_access.id

  description = "Ranger Audit Managed Identity ID"
}

output "azure_log_identity_id" {
  value = azurerm_user_assigned_identity.cdp_log_data_access.id

  description = "Log Data Access Managed Identity ID"

}

output "azure_raz_identity_id" {
  value = (var.enable_raz) ? azurerm_user_assigned_identity.cdp_raz[0].id : ""

  description = "RAZ Managed Identity ID. Value returned if RAZ is enabled"
}
