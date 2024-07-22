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

locals {
  # ------- Global settings -------
  env_tags = merge(var.agent_source_tag, (
    coalesce(var.env_tags,
      { env_prefix = var.env_prefix }
    ))
  )

  # ------- Network Resources -------
  resourcegroup_name = coalesce(var.resourcegroup_name, "${var.env_prefix}-rmgp")

  vnet_name = coalesce(var.vnet_name, "${var.env_prefix}-net")

  # Security Groups
  security_group_default_name = coalesce(var.security_group_default_name, "${var.env_prefix}-default-sg")

  security_group_knox_name = coalesce(var.security_group_knox_name, "${var.env_prefix}-knox-sg")

  cdp_resourcegroup_name = (var.create_vnet ?
  azurerm_resource_group.cdp_rmgp[0].name : var.cdp_resourcegroup_name)

  cdp_vnet_name = (var.create_vnet ?
  module.azure_cdp_vnet[0].vnet_name : var.cdp_vnet_name)

  cdp_vnet_id = (var.create_vnet ?
  module.azure_cdp_vnet[0].vnet_id : null)

  cdp_vnet_address_space = (var.create_vnet ?
  module.azure_cdp_vnet[0].vnet_cdp_vnet_address_space : null)

  cdp_subnet_names = (var.create_vnet ?
  module.azure_cdp_vnet[0].vnet_cdp_subnet_names : var.cdp_subnet_names)

  cdp_gateway_subnet_names = (var.create_vnet ?
  module.azure_cdp_vnet[0].vnet_gateway_subnet_names : var.cdp_gw_subnet_names)

  cdp_delegated_subnet_names = (var.create_vnet ?
  module.azure_cdp_vnet[0].vnet_delegated_subnet_names : var.cdp_delegated_subnet_names)

  create_private_flexible_server_resources = coalesce(var.create_private_flexible_server_resources, (var.deployment_template != "public") ? true : false)


  # ------- Storage Resources -------
  storage_suffix = var.random_id_for_bucket ? one(random_id.bucket_suffix).hex : ""

  # Azure storage containers can only contain numbers and letters
  default_data_storage_name = "${replace(var.env_prefix, "/[-_]/", "")}stor"

  data_storage = {
    data_storage_bucket = try(var.data_storage.data_storage_bucket, local.default_data_storage_name)
    data_storage_object = try(var.data_storage.data_storage_object, "data")
  }
  log_storage = {
    log_storage_bucket = try(var.log_storage.log_storage_bucket, local.data_storage.data_storage_bucket)
    log_storage_object = try(var.log_storage.log_storage_object, "logs")
  }

  backup_storage = {
    backup_storage_bucket = try(var.backup_storage.backup_storage_bucket, local.data_storage.data_storage_bucket)
    backup_storage_object = try(var.backup_storage.backup_storage_object, "backups")
  }

  # ------- Authz Resources -------

  # xaccount app
  xaccount_app_name = coalesce(var.xaccount_app_name, "${var.env_prefix}-xaccount-app")

  # Managed Identities
  datalake_admin_managed_identity_name = coalesce(var.datalake_admin_managed_identity_name, "${var.env_prefix}-dladmin-identity")

  idbroker_managed_identity_name = coalesce(var.idbroker_managed_identity_name, "${var.env_prefix}-idbroker-identity")

  log_data_access_managed_identity_name = coalesce(var.log_data_access_managed_identity_name, "${var.env_prefix}-logs-identity")

  ranger_audit_data_access_managed_identity_name = coalesce(var.ranger_audit_data_access_managed_identity_name, "${var.env_prefix}-audit-identity")

  raz_managed_identity_name = coalesce(var.raz_managed_identity_name, "${var.env_prefix}-raz-identity")

  raz_storage_role_assignments = flatten([

    for k, v in azurerm_storage_account.cdp_storage_locations : [
      for role_assign in var.raz_storage_role_assignments : {
        scope       = v.id
        role        = role_assign.role,
        description = role_assign.description
      }
    ]
  ])

  # ---- Azure CML NFS Resources

  nfs_file_share_name      = coalesce(var.nfs_file_share_name, "${var.env_prefix}-nfs-file-share")
  nfs_storage_account_name = coalesce(var.nfs_storage_account_name, "${replace(var.env_prefix, "/[-_]/", "")}nfsstor")
  nfsvm_nic_name           = "${var.env_prefix}-nfs-vm-nic"
  nfsvm_public_ip_name     = "${var.env_prefix}-nfs-vm-public-ip"
  nfsvm_sg_name            = "${var.env_prefix}-nfs-vm-sg"
  nfs_vnet_link_name       = "${var.env_prefix}-nfs-vm-vent-link"
  nfsvm_name               = "${var.env_prefix}-nfs-vm"
  private_endpoint_prefix  = var.env_prefix
}
