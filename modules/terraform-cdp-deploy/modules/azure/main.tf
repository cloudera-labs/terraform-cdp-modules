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

# ------- CDP Credential -------
resource "cdp_environments_azure_credential" "cdp_cred" {
  credential_name = var.cdp_xacccount_credential_name
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  app_based = {
    application_id = var.xaccount_app_uuid
    secret_key     = var.xaccount_app_pword
  }
  description = "Azure Cross Account Credential for Azure env ${var.environment_name}"
}

# ------- Accept Azure Image Terms -------
resource "cdp_environments_azure_image_terms" "cdp_azure_images" {
  count = var.azure_accept_image_terms ? 1 : 0

  accepted = true
}

# ------- CDP Environment -------
resource "cdp_environments_azure_environment" "cdp_env" {
  environment_name = var.environment_name
  credential_name  = cdp_environments_azure_credential.cdp_cred.credential_name
  region           = var.region

  security_access = {
    default_security_group_id  = var.security_group_default_uri
    security_group_id_for_knox = var.security_group_knox_uri
  }

  log_storage = {
    storage_location_base        = var.log_storage_location
    backup_storage_location_base = var.backup_storage_location
    managed_identity             = var.log_identity_id
  }

  public_key = var.public_key_text

  use_public_ip = var.use_public_ips
  existing_network_params = {
    resource_group_name          = var.resource_group_name
    network_id                   = var.vnet_name
    subnet_ids                   = var.cdp_subnet_names
    aks_private_dns_zone_id      = var.azure_aks_private_dns_zone_id
    database_private_dns_zone_id = var.azure_database_private_dns_zone_id
    flexible_server_subnet_ids   = var.cdp_flexible_server_delegated_subnet_names
  }
  create_private_endpoints = var.create_private_endpoints

  endpoint_access_gateway_scheme     = var.endpoint_access_scheme
  endpoint_access_gateway_subnet_ids = (length(var.cdp_gateway_subnet_names) > 0) ? var.cdp_gateway_subnet_names : null

  # Set this parameter to deploy all resources into a single resource group
  resource_group_name = var.use_single_resource_group ? var.resource_group_name : null

  freeipa = {
    instance_count_by_group = var.freeipa_instances
    multi_az                = var.multiaz
    catalog                 = var.freeipa_catalog
    image_id                = var.freeipa_image_id
    instance_type           = var.freeipa_instance_type
    recipes                 = var.freeipa_recipes
  }

  proxy_config_name  = var.proxy_config_name
  workload_analytics = var.workload_analytics
  enable_tunnel      = var.enable_ccm_tunnel

  enable_outbound_load_balancer      = var.enable_outbound_load_balancer
  encryption_key_resource_group_name = var.encryption_key_resource_group_name
  encryption_key_url                 = var.encryption_key_url
  encryption_at_host                 = var.encryption_at_host

  polling_options = {
    async           = var.environment_async_creation
    polling_timeout = var.environment_polling_timeout
  }

  tags = var.tags

  depends_on = [
    cdp_environments_azure_credential.cdp_cred,
    cdp_environments_azure_image_terms.cdp_azure_images
  ]

}

# ------- CDP Admin Group -------
# Create group
resource "cdp_iam_group" "cdp_admin_group" {
  group_name                    = var.cdp_admin_group_name
  sync_membership_on_user_login = false
}

# TODO: Assign roles and resource roles to the group

# TODO: Assign users to the group

# ------- CDP User Group -------
# Create group
resource "cdp_iam_group" "cdp_user_group" {
  group_name                    = var.cdp_user_group_name
  sync_membership_on_user_login = false
}

# TODO: Assign roles and resource roles to the group

# TODO: Assign users to the group

# ------- IdBroker Mappings -------
resource "cdp_environments_id_broker_mappings" "cdp_idbroker" {
  environment_name = cdp_environments_azure_environment.cdp_env.environment_name
  environment_crn  = cdp_environments_azure_environment.cdp_env.crn

  ranger_audit_role                   = var.ranger_audit_identity_id
  data_access_role                    = var.datalakeadmin_identity_id
  ranger_cloud_access_authorizer_role = var.enable_raz ? var.raz_identity_id : null

  mappings = [{
    accessor_crn = cdp_iam_group.cdp_admin_group.crn
    role         = var.datalakeadmin_identity_id
    },
    {
      accessor_crn = cdp_iam_group.cdp_user_group.crn
      role         = var.datalakeadmin_identity_id
    }
  ]

  depends_on = [
    cdp_environments_azure_environment.cdp_env
  ]
}

# ------- CDP Datalake -------
resource "cdp_datalake_azure_datalake" "cdp_datalake" {
  datalake_name    = var.datalake_name
  environment_name = cdp_environments_azure_environment.cdp_env.environment_name

  managed_identity      = var.idbroker_identity_id
  storage_location_base = var.data_storage_location

  runtime           = var.datalake_version == "latest" ? null : var.datalake_version
  scale             = var.datalake_scale
  enable_ranger_raz = var.enable_raz
  multi_az          = var.datalake_scale == "LIGHT_DUTY" ? null : var.multiaz

  image        = var.datalake_image
  java_version = var.datalake_java_version
  recipes      = var.datalake_recipes

  polling_options = {
    async           = var.datalake_async_creation
    polling_timeout = var.datalake_polling_timeout
  }

  tags = var.tags

  depends_on = [
    cdp_environments_azure_credential.cdp_cred,
    cdp_environments_azure_environment.cdp_env,
    cdp_environments_id_broker_mappings.cdp_idbroker
  ]
}
