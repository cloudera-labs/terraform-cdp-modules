# Copyright 2025 Cloudera, Inc. All Rights Reserved.
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
resource "cdp_environments_aws_credential" "cdp_cred" {

  count = var.create_cdp_credential ? 1 : 0

  credential_name = var.cdp_xacccount_credential_name
  role_arn        = var.xaccount_role_arn
  description     = "AWS Cross Account Credential for AWS env ${var.environment_name}"
}

# ------- CDP Environment -------
resource "cdp_environments_aws_environment" "cdp_env" {
  environment_name = var.environment_name
  description      = var.environment_description
  credential_name  = local.cdp_xacccount_credential_name
  region           = var.region

  security_access = {
    cidr                       = var.security_access_cidr
    default_security_group_id  = var.security_group_default_id
    security_group_id_for_knox = var.security_group_knox_id
  }

  log_storage = {
    storage_location_base        = var.log_storage_location
    backup_storage_location_base = var.backup_storage_location
    instance_profile             = var.log_instance_profile_arn
  }

  authentication = {
    public_key    = var.public_key_text
    public_key_id = var.keypair_name
  }

  vpc_id                             = var.vpc_id
  subnet_ids                         = var.subnets_for_cdp
  endpoint_access_gateway_scheme     = var.endpoint_access_scheme
  endpoint_access_gateway_subnet_ids = (length(var.public_subnet_ids) > 0) ? var.public_subnet_ids : null

  freeipa = {
    instance_count_by_group = var.freeipa_instances
    multi_az                = var.multiaz
    catalog                 = var.freeipa_catalog
    image_id                = var.freeipa_image_id
    instance_type           = var.freeipa_instance_type
    recipes                 = var.freeipa_recipes
    os                      = var.freeipa_os
  }

  compute_cluster = {
    enabled       = var.compute_cluster_enabled
    configuration = var.compute_cluster_configuration
  }

  proxy_config_name   = var.proxy_config_name
  s3_guard_table_name = var.s3_guard_table_name
  workload_analytics  = var.workload_analytics
  enable_tunnel       = var.enable_ccm_tunnel

  encryption_key_arn = var.encryption_key_arn

  polling_options = {
    async                  = var.environment_async_creation
    call_failure_threshold = var.environment_call_failure_threshold
    polling_timeout        = var.environment_polling_timeout
  }

  cascading_delete = var.environment_cascading_delete
  tags             = var.tags

  depends_on = [
    cdp_environments_aws_credential.cdp_cred
  ]
}

# ------- CDP Group -------
# Create group
resource "cdp_iam_group" "cdp_groups" {
  for_each = {
    for k, v in coalesce(var.cdp_groups, []) : k.name => v
    if v.create_group
  }

  group_name                    = each.value.name
  sync_membership_on_user_login = each.value.sync_membership_on_user_login
}

# TODO: (When supported) Assign roles and resource roles to the group

# TODO: (When supported) Assign users to the group

# ------- IdBroker Mappings -------
resource "cdp_environments_id_broker_mappings" "cdp_idbroker" {
  environment_name = cdp_environments_aws_environment.cdp_env.environment_name
  environment_crn  = cdp_environments_aws_environment.cdp_env.crn

  ranger_audit_role                   = var.ranger_audit_role_arn
  data_access_role                    = var.datalake_admin_role_arn
  ranger_cloud_access_authorizer_role = var.enable_raz ? var.raz_role_arn : null

  mappings           = local.cdp_group_id_broker_mappings
  set_empty_mappings = length(local.cdp_group_id_broker_mappings) == 0 ? true : null

  depends_on = [
    cdp_iam_group.cdp_groups,
    cdp_environments_aws_environment.cdp_env
  ]
}

# ------- CDP Datalake -------
resource "cdp_datalake_aws_datalake" "cdp_datalake" {
  datalake_name    = var.datalake_name
  environment_name = cdp_environments_aws_environment.cdp_env.environment_name

  instance_profile      = var.idbroker_instance_profile_arn
  storage_location_base = var.data_storage_location

  runtime           = var.datalake_version == "latest" ? null : var.datalake_version
  scale             = var.datalake_scale
  enable_ranger_raz = var.enable_raz
  multi_az          = var.multiaz

  image        = var.datalake_image
  java_version = var.datalake_java_version
  recipes      = var.datalake_recipes

  polling_options = {
    async                  = var.datalake_async_creation
    call_failure_threshold = var.datalake_call_failure_threshold
    polling_timeout        = var.datalake_polling_timeout
  }

  tags = var.tags

  depends_on = [
    cdp_environments_aws_credential.cdp_cred,
    cdp_environments_aws_environment.cdp_env,
    cdp_environments_id_broker_mappings.cdp_idbroker
  ]
}
