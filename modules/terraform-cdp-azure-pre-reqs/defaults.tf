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

  # ------- CDP Environment Deployment -------
  datalake_scale = coalesce(
    var.datalake_scale,
    (var.deployment_template == "public" ?
      "LIGHT_DUTY" : "MEDIUM_DUTY_HA"
    )
  )

  # ------- Network Resources -------
  resourcegroup_name = coalesce(var.resourcegroup_name, "${var.env_prefix}-rmgp")

  vnet_name = coalesce(var.vnet_name, "${var.env_prefix}-net")

  # Security Groups
  security_group_default_name = coalesce(var.security_group_default_name, "${var.env_prefix}-default-sg")

  security_group_knox_name = coalesce(var.security_group_knox_name, "${var.env_prefix}-knox-sg")

  # Calculate number of subnets based on the deployment_type
  subnets_required = {
    total   = (var.deployment_template == "public") ? var.subnet_count : 2 * var.subnet_count
    public  = var.subnet_count
    private = (var.deployment_template == "public") ? 0 : var.subnet_count
  }

  # Public Network infrastructure
  public_subnets = (local.subnets_required.public == 0 ?
    [] :
    [
      for idx in range(local.subnets_required.public) :
      {
        name = "${var.env_prefix}-sbnt-pub-${format("%02d", idx + 1)}"
        cidr = cidrsubnet(var.vnet_cidr, ceil(log(local.subnets_required.total, 2)), idx)
      }
  ])

  # Private Network infrastructure
  private_subnets = (local.subnets_required.private == 0 ?
    [] :
    [
      for idx in range(local.subnets_required.private) :
      {
        name = "${var.env_prefix}-sbnt-pvt-${format("%02d", idx + 1)}"
        cidr = cidrsubnet(var.vnet_cidr, ceil(log(local.subnets_required.total, 2)), local.subnets_required.public + idx)
      }
  ])

  vnet_id = (var.create_vnet ?
  azurerm_virtual_network.cdp_vnet.name : var.cdp_vnet_id)

  public_subnet_ids = (var.create_vnet ?
  values(azurerm_subnet.cdp_public_subnets)[*].id : var.cdp_public_subnet_ids)
  public_subnet_names = (var.create_vnet ?
  values(azurerm_subnet.cdp_public_subnets)[*].name : var.cdp_public_subnet_ids)

  private_subnet_ids = (var.create_vnet ?
    values(azurerm_subnet.cdp_private_subnets)[*].id : var.cdp_private_subnet_ids
  )
  private_subnet_names = (var.create_vnet ?
    values(azurerm_subnet.cdp_private_subnets)[*].name : var.cdp_private_subnet_ids
  )

  # ------- Storage Resources -------
  storage_suffix = var.random_id_for_bucket ? "${one(random_id.bucket_suffix).hex}" : ""

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




}