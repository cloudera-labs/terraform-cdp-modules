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
module "azure_cdp_rmgp" {

  source = "../terraform-azure-resource-group"

  create_resource_group = var.create_vnet

  # Variables required when creating RG
  resourcegroup_name = var.create_vnet ? local.resourcegroup_name : null
  azure_region       = var.create_vnet ? var.azure_region : null
  tags               = var.create_vnet ? var.env_tags : null

  # Variables required when using pre-existing RG
  existing_resource_group_name = var.create_vnet ? null : var.cdp_resourcegroup_name

}

# ------- VNet -------
# Create the VNet & subnets if required
module "azure_cdp_vnet" {

  source = "../terraform-azure-vnet"

  create_vnet = var.create_vnet

  deployment_template = var.deployment_template
  resourcegroup_name  = local.cdp_resourcegroup_name

  # Variables required when creating VNet
  vnet_name   = var.create_vnet ? local.vnet_name : null
  vnet_cidr   = var.create_vnet ? var.vnet_cidr : null
  vnet_region = var.create_vnet ? var.azure_region : null

  cdp_subnet_prefix       = var.create_vnet ? "${var.env_prefix}-cdp-sbnt" : null
  gateway_subnet_prefix   = var.create_vnet ? "${var.env_prefix}-gw-sbnt" : null
  delegated_subnet_prefix = var.create_vnet ? "${var.env_prefix}-delegated-sbnt" : null

  subnet_count                                  = var.create_vnet ? var.subnet_count : null
  cdp_subnet_range                              = var.create_vnet ? var.cdp_subnet_range : null
  cdp_subnets_private_endpoint_network_policies = var.create_vnet ? var.cdp_subnets_private_endpoint_network_policies : null

  gateway_subnet_range                              = var.create_vnet ? var.gateway_subnet_range : null
  gateway_subnets_private_endpoint_network_policies = var.create_vnet ? var.gateway_subnets_private_endpoint_network_policies : null
  delegated_subnet_range                            = var.create_vnet ? var.delegated_subnet_range : null

  tags = var.create_vnet ? local.env_tags : null

  # Variables required for pre-existing VNet
  existing_vnet_name              = var.create_vnet ? null : var.cdp_vnet_name
  existing_cdp_subnet_names       = var.create_vnet ? null : var.cdp_subnet_names
  existing_gateway_subnet_names   = var.create_vnet ? null : var.cdp_gw_subnet_names
  existing_delegated_subnet_names = var.create_vnet ? null : var.cdp_delegated_subnet_names

  depends_on = [module.azure_cdp_rmgp]
}

# ------- Security Groups -------
# Default SG
resource "azurerm_network_security_group" "cdp_default_sg" {
  name                = local.security_group_default_name
  location            = module.azure_cdp_rmgp.resource_group_location
  resource_group_name = local.cdp_resourcegroup_name

  tags = merge(local.env_tags, { Name = local.security_group_default_name })

}

# Create security group rules for extra list of ingress rules
# TODO: How to handle the case where ingress_extra_cidrs_and_ports is []
resource "azurerm_network_security_rule" "cdp_default_sg_ingress_extra_access" {
  name                        = "AllowAccessForExtraCidrsAndPorts"
  priority                    = 201
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefixes     = var.ingress_extra_cidrs_and_ports.cidrs
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_ranges     = var.ingress_extra_cidrs_and_ports.ports
  resource_group_name         = local.cdp_resourcegroup_name
  network_security_group_name = azurerm_network_security_group.cdp_default_sg.name
}

# Knox SG
resource "azurerm_network_security_group" "cdp_knox_sg" {
  name                = local.security_group_knox_name
  location            = module.azure_cdp_rmgp.resource_group_location
  resource_group_name = local.cdp_resourcegroup_name

  tags = merge(local.env_tags, { Name = local.security_group_knox_name })

}


# Create security group rules for extra list of ingress rules
# TODO: How to handle the case where ingress_extra_cidrs_and_ports is []
resource "azurerm_network_security_rule" "cdp_knox_sg_ingress_extra_access" {
  name                        = "AllowAccessForExtraCidrsAndPorts"
  priority                    = 201
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefixes     = var.ingress_extra_cidrs_and_ports.cidrs
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_ranges     = var.ingress_extra_cidrs_and_ports.ports
  resource_group_name         = local.cdp_resourcegroup_name
  network_security_group_name = azurerm_network_security_group.cdp_knox_sg.name
}

# ------- Azure Storage Account -------
resource "random_id" "bucket_suffix" {
  count = var.random_id_for_bucket ? 1 : 0

  byte_length = 4
}

resource "azurerm_storage_account" "cdp_storage_locations" {
  # Create buckets for the unique list of buckets in data and log storage
  for_each = toset(concat([local.data_storage.data_storage_bucket], [local.log_storage.log_storage_bucket], [
    local.backup_storage.backup_storage_bucket
  ]))

  name                = "${each.value}${local.storage_suffix}"
  resource_group_name = local.cdp_resourcegroup_name
  location            = module.azure_cdp_rmgp.resource_group_location

  public_network_access_enabled = var.storage_public_network_access_enabled

  # TODO: Review and parameterize these options
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true

  tags = merge(local.env_tags, { Name = "${each.value}${local.storage_suffix}" })
}

resource "azurerm_storage_account_network_rules" "cdp_storage_access_rules" {

  for_each = { for k, v in azurerm_storage_account.cdp_storage_locations : k => v
  if var.create_azure_storage_network_rules }

  storage_account_id         = each.value.id
  default_action             = "Deny"
  ip_rules                   = [for cdr in var.ingress_extra_cidrs_and_ports.cidrs : can(regex("^[\\d.]{4}:/31|/32$", cdr)) ? replace(cdr, "/^([\\d.]{4}):/31|/32$/", "$1") : cdr]
  bypass                     = ["AzureServices"]
  virtual_network_subnet_ids = module.azure_cdp_vnet.vnet_cdp_subnet_ids
}

# ------- Azure Private endpoints for Storage Accounts -------
module "stor_private_endpoints" {
  count = var.create_azure_storage_private_endpoints ? 1 : 0

  source = "../terraform-azure-storage-endpoints"

  resourcegroup_name = local.cdp_resourcegroup_name
  azure_region       = var.azure_region
  vnet_name          = local.cdp_vnet_name

  private_endpoint_prefix              = var.env_prefix
  private_endpoint_storage_account_ids = values(azurerm_storage_account.cdp_storage_locations)[*].id
  private_endpoint_target_subnet_ids   = module.azure_cdp_vnet.vnet_cdp_subnet_ids

  tags = var.env_tags

  depends_on = [module.azure_cdp_vnet,
    azurerm_storage_account_network_rules.cdp_storage_access_rules
  ]
}

# ------- Azure Storage Containers -------
# Data Storage Objects
resource "azurerm_storage_container" "cdp_data_storage" {

  name                  = local.data_storage.data_storage_object
  storage_account_id    = azurerm_storage_account.cdp_storage_locations[local.data_storage.data_storage_bucket].id
  container_access_type = "private"

  depends_on = [
    azurerm_storage_account.cdp_storage_locations
  ]
}

# Log Storage Objects
resource "azurerm_storage_container" "cdp_log_storage" {

  name                  = local.log_storage.log_storage_object
  storage_account_id    = azurerm_storage_account.cdp_storage_locations[local.log_storage.log_storage_bucket].id
  container_access_type = "private"

  depends_on = [
    azurerm_storage_account.cdp_storage_locations
  ]
}

# Backup Storage Object
resource "azurerm_storage_container" "cdp_backup_storage" {

  name                  = local.backup_storage.backup_storage_object
  storage_account_id    = azurerm_storage_account.cdp_storage_locations[local.backup_storage.backup_storage_bucket].id
  container_access_type = "private"

  depends_on = [
    azurerm_storage_account.cdp_storage_locations
  ]
}

# ------- Resources for Private Flexible Servers -------
resource "azurerm_private_dns_zone" "flexible_server_dns_zone" {

  count = local.create_private_flexible_server_resources ? 1 : 0

  name                = "${var.env_prefix}.postgres.database.azure.com"
  resource_group_name = local.cdp_resourcegroup_name

  tags = merge(local.env_tags)
}

resource "azurerm_private_dns_zone_virtual_network_link" "flexible_server_vnet_link" {

  count = local.create_private_flexible_server_resources ? 1 : 0

  name                  = "${var.env_prefix}.flex-server-vent-link"
  resource_group_name   = local.cdp_resourcegroup_name
  private_dns_zone_name = azurerm_private_dns_zone.flexible_server_dns_zone[0].name
  virtual_network_id    = module.azure_cdp_vnet.vnet_id

  tags = merge(local.env_tags)
}

# ------- Azure Cross Account App -------

# Create Azure AD Application
resource "azuread_application" "cdp_xaccount_app" {
  display_name = local.xaccount_app_name

  owners = [data.azuread_client_config.current.object_id]
}

# Create Service Principal associated with the Azure AD App
resource "azuread_service_principal" "cdp_xaccount_app_sp" {
  client_id = azuread_application.cdp_xaccount_app.client_id

  owners = [data.azuread_client_config.current.object_id]
}

# Create role assignment for Service Principal
resource "azurerm_role_assignment" "cdp_xaccount_role" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.cdp_xaccount_app_sp.id
}

# Create Application password (client secret)
resource "azuread_application_password" "cdp_xaccount_app_password" {
  application_id    = azuread_application.cdp_xaccount_app.id
  end_date_relative = "17520h" #expire in 2 years # TODO: Review and parameterize
}

# ------- Azure Managed Identities & Role Asignment - IDBroker -------

# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_idbroker" {
  location            = module.azure_cdp_rmgp.resource_group_location
  name                = local.idbroker_managed_identity_name
  resource_group_name = local.cdp_resourcegroup_name

  tags = merge(local.env_tags, { Name = local.idbroker_managed_identity_name })
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
  location            = module.azure_cdp_rmgp.resource_group_location
  name                = local.datalake_admin_managed_identity_name
  resource_group_name = local.cdp_resourcegroup_name

  tags = merge(local.env_tags, { Name = local.datalake_admin_managed_identity_name })
}

# Assign the required roles to the managed identity for Data storage container
resource "azurerm_role_assignment" "cdp_datalake_admin_data_container_assign" {

  for_each = { for idx, role in var.datalake_admin_data_container_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_data_storage.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_datalake_admin.principal_id

  description = each.value.description
}

# Assign the required roles to the managed identity for Log storage container
resource "azurerm_role_assignment" "cdp_datalake_admin_log_container_assign" {

  for_each = { for idx, role in var.datalake_admin_log_container_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_log_storage.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_datalake_admin.principal_id

  description = each.value.description
}

# Assign the required roles to the managed identity for Backup storage container
resource "azurerm_role_assignment" "cdp_datalake_admin_backup_container_assign" {

  for_each = { for idx, role in var.datalake_admin_backup_container_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_backup_storage.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_datalake_admin.principal_id

  description = each.value.description
}

# ------- Azure Managed Identities & Role Asignment - Log Data Access -------

# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_log_data_access" {
  location            = module.azure_cdp_rmgp.resource_group_location
  name                = local.log_data_access_managed_identity_name
  resource_group_name = local.cdp_resourcegroup_name

  tags = merge(local.env_tags, { Name = local.log_data_access_managed_identity_name })
}

# Assign the required roles to the managed identity
resource "azurerm_role_assignment" "cdp_log_data_access_log_container_assign" {

  for_each = { for idx, role in var.log_data_access_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_log_storage.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_log_data_access.principal_id

  description = each.value.description
}

resource "azurerm_role_assignment" "cdp_log_data_access_backup_container_assign" {

  for_each = { for idx, role in var.log_data_access_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_backup_storage.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_log_data_access.principal_id

  description = each.value.description
}

# ------- Azure Managed Identities & Role Asignment - Ranger Audit -------

# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_ranger_audit_data_access" {
  location            = module.azure_cdp_rmgp.resource_group_location
  name                = local.ranger_audit_data_access_managed_identity_name
  resource_group_name = local.cdp_resourcegroup_name

  tags = merge(local.env_tags, { Name = local.ranger_audit_data_access_managed_identity_name })
}

# Assign the required roles to the managed identity
resource "azurerm_role_assignment" "cdp_ranger_audit_data_container_assign" {

  for_each = { for idx, role in var.ranger_audit_data_container_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_data_storage.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_ranger_audit_data_access.principal_id

  description = each.value.description
}

resource "azurerm_role_assignment" "cdp_ranger_audit_log_container_assign" {

  for_each = { for idx, role in var.ranger_audit_log_container_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_log_storage.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_ranger_audit_data_access.principal_id

  description = each.value.description
}

resource "azurerm_role_assignment" "cdp_ranger_audit_backup_container_assign" {

  for_each = { for idx, role in var.ranger_audit_backup_container_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_backup_storage.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_ranger_audit_data_access.principal_id

  description = each.value.description
}

# ------- Azure Managed Identities & Role Asignment - RAZ -------

# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_raz" {

  count = var.enable_raz ? 1 : 0

  location            = module.azure_cdp_rmgp.resource_group_location
  name                = local.raz_managed_identity_name
  resource_group_name = local.cdp_resourcegroup_name

  tags = merge(local.env_tags, { Name = local.raz_managed_identity_name })
}

# Assign the required roles to the managed identity
resource "azurerm_role_assignment" "cdp_raz_assign" {

  for_each = {
    for idx, item in local.raz_storage_role_assignments : idx => item
    if var.enable_raz == true
  }

  scope                = each.value.scope
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_raz[0].principal_id

  description = each.value.description
}

module "azure_cml_nfs" {
  count  = var.create_azure_cml_nfs ? 1 : 0
  source = "../terraform-azure-nfs"

  resourcegroup_name                       = local.cdp_resourcegroup_name
  azure_region                             = var.azure_region
  nfs_file_share_name                      = local.nfs_file_share_name
  nfs_file_share_size                      = var.nfs_file_share_size
  nfs_private_endpoint_target_subnet_names = local.cdp_subnet_names
  vnet_name                                = local.cdp_vnet_name
  nfs_storage_account_name                 = local.nfs_storage_account_name
  source_address_prefixes                  = var.ingress_extra_cidrs_and_ports.cidrs
  nfsvm_nic_name                           = local.nfsvm_nic_name
  nfsvm_public_ip_name                     = local.nfsvm_public_ip_name
  nfsvm_sg_name                            = local.nfsvm_sg_name
  nfs_vnet_link_name                       = local.nfs_vnet_link_name
  nfsvm_name                               = local.nfsvm_name
  public_key_text                          = var.public_key_text
  private_endpoint_prefix                  = local.private_endpoint_prefix
  create_vm_mounting_nfs                   = var.create_vm_mounting_nfs

  depends_on = [
    module.azure_cdp_rmgp,
    module.azure_cdp_vnet
  ]
}
