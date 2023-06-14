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

  tags = merge(local.env_tags, { Name = local.resourcegroup_name })
}

# ------- VNet -------
# TODO: Move this to a sub-module & find existing TF modules
# https://github.com/Azure/terraform-azurerm-network
resource "azurerm_virtual_network" "cdp_vnet" {
  name                = local.vnet_name
  location            = azurerm_resource_group.cdp_rmgp.location
  resource_group_name = azurerm_resource_group.cdp_rmgp.name
  address_space       = [var.vnet_cidr]
  dns_servers         = []

  tags = merge(local.env_tags, { Name = local.vnet_name })
}

# ------- Subnets -------
# TODO: Revisit need for pub vs. priv subnet
# TODO: Better planning of VNet & subnets as per: https://docs.cloudera.com/cdp-public-cloud/cloud/requirements-azure/topics/mc-azure-vnet-and-subnets.html

# Azure VNet Public Subnets
resource "azurerm_subnet" "cdp_public_subnets" {

  for_each = { for idx, subnet in local.public_subnets : idx => subnet }

  virtual_network_name = azurerm_virtual_network.cdp_vnet.name
  resource_group_name  = azurerm_resource_group.cdp_rmgp.name
  name                 = each.value.name
  address_prefixes     = [each.value.cidr]

  service_endpoints                         = ["Microsoft.Sql", "Microsoft.Storage"]
  private_endpoint_network_policies_enabled = true

}

# Azure VNet Pricate Subnets
resource "azurerm_subnet" "cdp_private_subnets" {

  for_each = { for idx, subnet in local.private_subnets : idx => subnet }

  virtual_network_name = azurerm_virtual_network.cdp_vnet.name
  resource_group_name  = azurerm_resource_group.cdp_rmgp.name
  name                 = each.value.name
  address_prefixes     = [each.value.cidr]

  service_endpoints                         = ["Microsoft.Sql", "Microsoft.Storage"]
  private_endpoint_network_policies_enabled = true

}

# ------- Security Groups -------
# Default SG
resource "azurerm_network_security_group" "cdp_default_sg" {
  name                = local.security_group_default_name
  location            = azurerm_resource_group.cdp_rmgp.location
  resource_group_name = azurerm_resource_group.cdp_rmgp.name

  tags = merge(local.env_tags, { Name = local.security_group_default_name })

}

# Create security group rules for CDP control plane ingress
# TODO: This may not be needed with CCMv2
resource "azurerm_network_security_rule" "cdp_default_sg_ingress_cdp_control_plane" {
  name                        = "AllowAccessForCDPControlPlane"
  priority                    = 901
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefixes     = var.cdp_control_plane_cidrs
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_ranges     = [443, 9443]
  resource_group_name         = azurerm_resource_group.cdp_rmgp.name
  network_security_group_name = azurerm_network_security_group.cdp_default_sg.name
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
  resource_group_name         = azurerm_resource_group.cdp_rmgp.name
  network_security_group_name = azurerm_network_security_group.cdp_default_sg.name
}

# Knox SG
resource "azurerm_network_security_group" "cdp_knox_sg" {
  name                = local.security_group_knox_name
  location            = azurerm_resource_group.cdp_rmgp.location
  resource_group_name = azurerm_resource_group.cdp_rmgp.name

  tags = merge(local.env_tags, { Name = local.security_group_knox_name })

}

# Create security group rules for CDP control plane ingress
# TODO: This may not be needed with CCMv2
resource "azurerm_network_security_rule" "cdp_knox_sg_ingress_cdp_control_plane" {
  name                        = "AllowAccessForCDPControlPlane"
  priority                    = 901
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefixes     = var.cdp_control_plane_cidrs
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_ranges     = [443, 9443]
  resource_group_name         = azurerm_resource_group.cdp_rmgp.name
  network_security_group_name = azurerm_network_security_group.cdp_knox_sg.name
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
  resource_group_name         = azurerm_resource_group.cdp_rmgp.name
  network_security_group_name = azurerm_network_security_group.cdp_knox_sg.name
}


# ------- Azure Storage Account -------
resource "random_id" "bucket_suffix" {
  count = var.random_id_for_bucket ? 1 : 0

  byte_length = 4
}

resource "azurerm_storage_account" "cdp_storage_locations" {
  # Create buckets for the unique list of buckets in data and log storage
  for_each = toset(concat([local.data_storage.data_storage_bucket], [local.log_storage.log_storage_bucket], [local.backup_storage.backup_storage_bucket]))

  name                = "${each.value}${local.storage_suffix}"
  resource_group_name = azurerm_resource_group.cdp_rmgp.name
  location            = azurerm_resource_group.cdp_rmgp.location

  # TODO: Review and parameterize these options
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true

  tags = merge(local.env_tags, { Name = "${each.value}${local.storage_suffix}" })
}

# ------- Azure Storage Containers -------
# Data Storage Objects
resource "azurerm_storage_container" "cdp_data_storage" {

  name                  = local.data_storage.data_storage_object
  storage_account_name  = "${local.data_storage.data_storage_bucket}${local.storage_suffix}"
  container_access_type = "private"

  depends_on = [
    azurerm_storage_account.cdp_storage_locations
  ]
}

# Log Storage Objects
resource "azurerm_storage_container" "cdp_log_storage" {

  name                  = local.log_storage.log_storage_object
  storage_account_name  = "${local.log_storage.log_storage_bucket}${local.storage_suffix}"
  container_access_type = "private"

  depends_on = [
    azurerm_storage_account.cdp_storage_locations
  ]
}

# Backup Storage Object
resource "azurerm_storage_container" "cdp_backup_storage" {

  name                  = local.backup_storage.backup_storage_object
  storage_account_name  = "${local.backup_storage.backup_storage_bucket}${local.storage_suffix}"
  container_access_type = "private"

  depends_on = [
    azurerm_storage_account.cdp_storage_locations
  ]
}

# NOTE: I don't think below is needed by default - it's a customization
# ------- Azure Cross Account Role -------

# resource "azurerm_role_definition" "cdp_xaccount_role" {
#   # TODO:
#   name        = local.xaccount_role_name
#   # TODO:
#   scope       = data.azurerm_subscription.primary.id
#   description = "CDP Cross Account role for ${var.env_prefix}"

#   # TODO:
#   permissions {
#     actions     = ["*"]
#     data_actions = []
#     not_actions = []
#     not_data_actions =
#   }

#   # TODO:
#   assignable_scopes = [
#     data.azurerm_subscription.primary.id, # /subscriptions/00000000-0000-0000-0000-000000000000
#   ]
# }


# ------- Azure Cross Account App -------

# Create Azure AD Application
resource "azuread_application" "cdp_xaccount_app" {
  display_name = local.xaccount_app_name

  owners = [data.azuread_client_config.current.object_id]
}

# Create Service Principal associated with the Azure AD App
resource "azuread_service_principal" "cdp_xaccount_app_sp" {
  application_id = azuread_application.cdp_xaccount_app.application_id

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
  application_object_id = azuread_application.cdp_xaccount_app.object_id
  end_date_relative     = "17520h" #expire in 2 years # TODO: Review and parameterize
}

# ------- Azure Managed Identities & Role Asignment - IDBroker -------

# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_idbroker" {
  location            = azurerm_resource_group.cdp_rmgp.location
  name                = local.idbroker_managed_identity_name
  resource_group_name = azurerm_resource_group.cdp_rmgp.name

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
  location            = azurerm_resource_group.cdp_rmgp.location
  name                = local.datalake_admin_managed_identity_name
  resource_group_name = azurerm_resource_group.cdp_rmgp.name

  tags = merge(local.env_tags, { Name = local.datalake_admin_managed_identity_name })
}

# Assign the required roles to the managed identity for Data storage container
resource "azurerm_role_assignment" "cdp_datalake_admin_data_container_assign" {

  for_each = { for idx, role in var.datalake_admin_data_container_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_data_storage.resource_manager_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_datalake_admin.principal_id

  description = each.value.description
}

# Assign the required roles to the managed identity for Log storage container
resource "azurerm_role_assignment" "cdp_datalake_admin_log_container_assign" {

  for_each = { for idx, role in var.datalake_admin_log_container_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_log_storage.resource_manager_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_datalake_admin.principal_id

  description = each.value.description
}

# Assign the required roles to the managed identity for Backup storage container
resource "azurerm_role_assignment" "cdp_datalake_admin_backup_container_assign" {

  for_each = { for idx, role in var.datalake_admin_backup_container_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_backup_storage.resource_manager_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_datalake_admin.principal_id

  description = each.value.description
}

# ------- Azure Managed Identities & Role Asignment - Log Data Access -------

# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_log_data_access" {
  location            = azurerm_resource_group.cdp_rmgp.location
  name                = local.log_data_access_managed_identity_name
  resource_group_name = azurerm_resource_group.cdp_rmgp.name

  tags = merge(local.env_tags, { Name = local.log_data_access_managed_identity_name })
}

# Assign the required roles to the managed identity
resource "azurerm_role_assignment" "cdp_log_data_access_assign" {

  for_each = { for idx, role in var.log_data_access_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_log_storage.resource_manager_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_log_data_access.principal_id

  description = each.value.description
}

# ------- Azure Managed Identities & Role Asignment - Ranger Audit -------

# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_ranger_audit_data_access" {
  location            = azurerm_resource_group.cdp_rmgp.location
  name                = local.ranger_audit_data_access_managed_identity_name
  resource_group_name = azurerm_resource_group.cdp_rmgp.name

  tags = merge(local.env_tags, { Name = local.ranger_audit_data_access_managed_identity_name })
}

# Assign the required roles to the managed identity
resource "azurerm_role_assignment" "cdp_ranger_audit_data_container_assign" {

  for_each = { for idx, role in var.ranger_audit_data_container_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_data_storage.resource_manager_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_ranger_audit_data_access.principal_id

  description = each.value.description
}

resource "azurerm_role_assignment" "cdp_ranger_audit_log_container_assign" {

  for_each = { for idx, role in var.ranger_audit_log_container_role_assignments : idx => role }

  scope                = azurerm_storage_container.cdp_log_storage.resource_manager_id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_ranger_audit_data_access.principal_id

  description = each.value.description
}

# ------- Azure Managed Identities & Role Asignment - RAZ -------

# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_raz" {

  count = var.enable_raz ? 1 : 0

  location            = azurerm_resource_group.cdp_rmgp.location
  name                = local.raz_managed_identity_name
  resource_group_name = azurerm_resource_group.cdp_rmgp.name

  tags = merge(local.env_tags, { Name = local.raz_managed_identity_name })
}

# Assign the required roles to the managed identity
resource "azurerm_role_assignment" "cdp_raz_assign" {

  for_each = { for idx, item in local.raz_storage_role_assignments : idx => item
  if var.enable_raz == true }

  scope                = each.value.scope
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_raz[0].principal_id

  description = each.value.description
}
