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
resource "cdp_environments_gcp_credential" "cdp_cred" {

  count = var.create_cdp_credential ? 1 : 0

  credential_name = var.cdp_xacccount_credential_name
  credential_key  = var.xaccount_service_account_private_key
  description     = "CDP Credential for GCP env ${var.environment_name}"
}

# ------- CDP Environment -------
resource "cdp_environments_gcp_environment" "cdp_env" {
  environment_name = var.environment_name
  credential_name  = local.cdp_xacccount_credential_name
  region           = var.region

  security_access = {
    default_security_group_id  = var.firewall_default_id
    security_group_id_for_knox = var.firewall_knox_id
  }

  log_storage = {
    storage_location_base        = var.log_storage_location
    backup_storage_location_base = var.backup_storage_location
    service_account_email        = var.log_service_account_email
  }
  public_key = var.public_key_text

  use_public_ip = var.use_public_ips

  existing_network_params = {
    network_name      = var.network_name
    shared_project_id = var.project_id
    subnet_names      = var.cdp_subnet_names
  }

  endpoint_access_gateway_scheme = var.endpoint_access_scheme

  encryption_key    = var.encryption_key
  proxy_config_name = var.proxy_config_name

  freeipa = {
    instance_count_by_group = var.freeipa_instances
    instance_type           = var.freeipa_instance_type
    recipes                 = var.freeipa_recipes
  }

  workload_analytics     = var.workload_analytics
  report_deployment_logs = var.report_deployment_logs
  enable_tunnel          = var.enable_ccm_tunnel


  polling_options = {
    async           = var.environment_async_creation
    polling_timeout = var.environment_polling_timeout
  }

  tags = var.tags

  depends_on = [
    cdp_environments_gcp_credential.cdp_cred
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
  environment_name = cdp_environments_gcp_environment.cdp_env.environment_name
  environment_crn  = cdp_environments_gcp_environment.cdp_env.crn

  ranger_audit_role = var.ranger_audit_service_account_email
  data_access_role  = var.datalake_admin_service_account_email

  mappings = [{
    accessor_crn = cdp_iam_group.cdp_admin_group.crn
    role         = var.datalake_admin_service_account_email
    },
    {
      accessor_crn = cdp_iam_group.cdp_user_group.crn
      role         = var.datalake_admin_service_account_email
    }
  ]

  depends_on = [
    cdp_environments_gcp_environment.cdp_env
  ]
}

# ------- CDP Datalake -------
resource "cdp_datalake_gcp_datalake" "cdp_datalake" {
  datalake_name    = var.datalake_name
  environment_name = cdp_environments_gcp_environment.cdp_env.environment_name

  cloud_provider_configuration = {
    service_account_email = var.idbroker_service_account_email
    storage_location      = var.data_storage_location
  }

  runtime = var.datalake_version == "latest" ? null : var.datalake_version
  scale   = var.datalake_scale

  custom_instance_groups = var.datalake_custom_instance_groups
  image                  = var.datalake_image
  java_version           = var.datalake_java_version
  recipes                = var.datalake_recipes

  polling_options = {
    async           = var.datalake_async_creation
    polling_timeout = var.datalake_polling_timeout
  }

  tags = var.tags

  depends_on = [
    cdp_environments_gcp_credential.cdp_cred,
    cdp_environments_gcp_environment.cdp_env,
    cdp_environments_id_broker_mappings.cdp_idbroker
  ]
}

