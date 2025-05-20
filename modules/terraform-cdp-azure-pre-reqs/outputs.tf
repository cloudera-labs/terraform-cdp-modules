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

output "azure_cdp_resource_group_name" {
  value = module.azure_cdp_rmgp.resource_group_name

  description = "Azure Resource Group Name"
}

output "azure_network_resource_group_name" {
  value = try(module.azure_network_rmgp[0].resource_group_name, module.azure_cdp_rmgp.resource_group_name)

  description = "Azure Resource Group Name"
}

output "azure_vnet_name" {
  value = local.cdp_vnet_name

  description = "Azure Virtual Network Name"
}

output "azure_vnet_id" {
  description = "Azure Virtual Network ID"
  value       = local.cdp_vnet_id
}

output "azure_vnet_adress_space" {
  description = "Azure Virtual Network Address Space"
  value       = local.cdp_vnet_address_space
}

output "azure_cdp_subnet_names" {
  value = local.cdp_subnet_names

  description = "Azure Virtual Subnet Names for CDP Resources"
}

output "azure_cdp_gateway_subnet_names" {
  value = local.cdp_gateway_subnet_names

  description = "Azure Virtual Subnet Names for CDP Endpoint Access Gateway"
}

output "azure_cdp_flexible_server_delegated_subnet_names" {
  value = local.cdp_delegated_subnet_names

  description = "Azure Virtual Subnet Names delegated for Private Flexible servers."

}

output "azure_database_private_dns_zone_id" {
  value = (local.create_private_flexible_server_resources) ? azurerm_private_dns_zone.flexible_server_dns_zone[0].id : null

  description = "The ID of an Azure private DNS zone used for the database."
}

output "azure_security_group_default_uri" {
  value = azurerm_network_security_group.cdp_default_sg.id

  description = "Azure Default Security Group URI"
}

output "azure_security_group_knox_uri" {
  value = azurerm_network_security_group.cdp_knox_sg.id

  description = "Azure Knox Security Group URI"
}

output "azure_data_storage_account" {
  value = azurerm_storage_account.cdp_storage_locations[local.data_storage.data_storage_bucket].name

  description = "Azure data storage account name"
}

output "azure_data_storage_container" {
  value = azurerm_storage_container.cdp_data_storage.name

  description = "Azure data storage container name"
}

output "azure_data_storage_location" {
  value = "abfs://${azurerm_storage_container.cdp_data_storage.name}@${azurerm_storage_account.cdp_storage_locations[local.data_storage.data_storage_bucket].name}.dfs.core.windows.net"

  description = "Azure data storage location"

}

output "azure_log_storage_account" {
  value = azurerm_storage_account.cdp_storage_locations[local.log_storage.log_storage_bucket].name

  description = "Azure log storage account name"
}

output "azure_log_storage_container" {
  value = azurerm_storage_container.cdp_log_storage.name

  description = "Azure log storage container name"
}

output "azure_log_storage_location" {
  value = "abfs://${azurerm_storage_container.cdp_log_storage.name}@${azurerm_storage_account.cdp_storage_locations[local.log_storage.log_storage_bucket].name}.dfs.core.windows.net"

  description = "Azure log storage location"

}

output "azure_backup_storage_account" {
  value = azurerm_storage_account.cdp_storage_locations[local.backup_storage.backup_storage_bucket].name

  description = "Azure backup storage account name"
}

output "azure_backup_storage_container" {
  value = azurerm_storage_container.cdp_backup_storage.name

  description = "Azure backup storage container name"
}

output "azure_backup_storage_location" {
  value = "abfs://${azurerm_storage_container.cdp_backup_storage.name}@${azurerm_storage_account.cdp_storage_locations[local.backup_storage.backup_storage_bucket].name}.dfs.core.windows.net"


  description = "Azure backup storage location"

}

output "azure_xaccount_app_uuid" {
  value = azuread_application.cdp_xaccount_app.client_id

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


output "nfs_file_share_url" {
  value       = var.create_azure_cml_nfs ? module.azure_cml_nfs[0].nfs_file_share_url : null
  description = "NFS File Share Url"
}

output "nfs_storage_account_name" {
  value       = var.create_azure_cml_nfs ? module.azure_cml_nfs[0].nfs_storage_account_name : null
  description = "NFS Storage Account Name"
}

output "nfs_vm_public_ip" {
  value       = var.create_azure_cml_nfs ? module.azure_cml_nfs[0].nfs_vm_public_ip : null
  description = "NFS VM Public IP"
}

output "nfs_vm_username" {
  value       = var.create_azure_cml_nfs ? module.azure_cml_nfs[0].nfs_vm_username : null
  description = "NFS VM Admin Username"
}

output "nfs_vm_mount_path" {
  value       = var.create_azure_cml_nfs ? module.azure_cml_nfs[0].nfs_vm_mount_path : null
  description = "Path where NFS is mounted on the VM"
}