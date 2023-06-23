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

# ------- Call sub-module for Azure Deployment -------
module "cdp_on_azure" {
  count = (var.infra_type == "azure") ? 1 : 0

  source = "./modules/azure"

  tags = local.env_tags

  environment_name              = local.environment_name
  datalake_name                 = local.datalake_name
  cdp_xacccount_credential_name = local.cdp_xacccount_credential_name
  cdp_admin_group_name          = local.cdp_admin_group_name
  cdp_user_group_name           = local.cdp_user_group_name

  security_group_default_uri = var.azure_security_group_default_uri
  security_group_knox_uri    = var.azure_security_group_knox_uri

  datalake_scale     = local.datalake_scale
  datalake_version   = var.datalake_version
  enable_ccm_tunnel  = var.enable_ccm_tunnel
  enable_raz         = var.enable_raz
  freeipa_instances  = var.freeipa_instances
  workload_analytics = var.workload_analytics

  cdp_profile              = var.cdp_profile
  cdp_control_plane_region = var.cdp_control_plane_region

  use_single_resource_group = var.use_single_resource_group
  use_public_ips            = local.use_public_ips

  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id

  region              = var.region
  resource_group_name = var.azure_resource_group_name
  vnet_name           = var.azure_vnet_name
  subnet_names        = var.azure_subnet_names
  public_key_text     = var.public_key_text

  data_storage_location   = var.data_storage_location
  log_storage_location    = var.log_storage_location
  backup_storage_location = var.backup_storage_location

  xaccount_app_uuid  = var.azure_xaccount_app_uuid
  xaccount_app_pword = var.azure_xaccount_app_pword

  idbroker_identity_id      = var.azure_idbroker_identity_id
  datalakeadmin_identity_id = var.azure_datalakeadmin_identity_id
  ranger_audit_identity_id  = var.azure_ranger_audit_identity_id
  log_identity_id           = var.azure_log_identity_id
  raz_identity_id           = var.azure_raz_identity_id
}
