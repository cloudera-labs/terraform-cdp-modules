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
resource "cdp_environments_aws_credential" "cdp_cred" {
  credential_name = var.cdp_xacccount_credential_name
  role_arn        = var.xaccount_role_arn
  description     = "AWS Cross Account Credential for AWS env ${var.environment_name}"
}

# ------- CDP Environment -------
resource "cdp_environments_aws_environment" "cdp_env" {
  environment_name = var.environment_name
  credential_name  = cdp_environments_aws_credential.cdp_cred.credential_name
  region           = var.region

  security_access = {
    default_security_group_id  = var.security_group_default_id
    security_group_id_for_knox = var.security_group_knox_id
  }

  log_storage = {
    storage_location_base        = var.log_storage_location
    backup_storage_location_base = var.backup_storage_location
    instance_profile             = var.log_instance_profile_arn
  }

  authentication = {
    public_key_id = var.keypair_name
  }

  vpc_id                             = var.vpc_id
  subnet_ids                         = var.subnets_for_cdp
  endpoint_access_gateway_scheme     = var.endpoint_access_scheme
  endpoint_access_gateway_subnet_ids = (length(var.public_subnet_ids) > 0) ? var.public_subnet_ids : null

  freeipa = {
    instance_count_by_group = var.freeipa_instances
    multi_az                = var.multiaz
  }

  workload_analytics = var.workload_analytics
  enable_tunnel      = var.enable_ccm_tunnel
  # tags               = var.tags # NOTE: Waiting on provider fix

  depends_on = [
    cdp_environments_aws_credential.cdp_cred
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
  environment_name = cdp_environments_aws_environment.cdp_env.environment_name
  environment_crn  = cdp_environments_aws_environment.cdp_env.crn

  ranger_audit_role                   = var.ranger_audit_role_arn
  data_access_role                    = var.datalake_admin_role_arn
  ranger_cloud_access_authorizer_role = var.enable_raz ? var.datalake_admin_role_arn : null

  mappings = [{
    accessor_crn = cdp_iam_group.cdp_admin_group.crn
    role         = var.datalake_admin_role_arn
    },
    {
      accessor_crn = cdp_iam_group.cdp_user_group.crn
      role         = var.datalake_admin_role_arn
    }
  ]

  depends_on = [
    cdp_environments_aws_environment.cdp_env
  ]
}

# ------- CDP Datalake -------
resource "cdp_datalake_aws_datalake" "cdp_datalake" {
  datalake_name    = var.datalake_name
  environment_name = cdp_environments_aws_environment.cdp_env.environment_name

  instance_profile        = var.idbroker_instance_profile_arn
  storage_bucket_location = var.data_storage_location

  runtime           = var.datalake_version == "latest" ? null : var.datalake_version
  scale             = var.datalake_scale
  enable_ranger_raz = var.enable_raz
  multi_az          = var.multiaz

  custom_instance_groups = var.datalake_custom_instance_groups
  image                  = var.datalake_image
  java_version           = var.datalake_java_version
  recipes                = var.datalake_recipes
  # tags = var.tags # NOTE: Waiting on provider fix

  depends_on = [
    cdp_environments_aws_credential.cdp_cred,
    cdp_environments_aws_environment.cdp_env,
    cdp_environments_id_broker_mappings.cdp_idbroker
  ]
}
