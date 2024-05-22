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

# ------- Call sub-module for AWS Deployment -------
module "cdp_on_aws" {
  count = (var.infra_type == "aws") ? 1 : 0

  source = "./modules/aws"

  tags = local.env_tags

  environment_name              = local.environment_name
  datalake_name                 = local.datalake_name
  create_cdp_credential         = var.create_cdp_credential
  cdp_xacccount_credential_name = local.cdp_xacccount_credential_name
  cdp_admin_group_name          = local.cdp_admin_group_name
  cdp_user_group_name           = local.cdp_user_group_name

  security_group_default_id = var.aws_security_group_default_id
  security_group_knox_id    = var.aws_security_group_knox_id
  security_access_cidr      = var.aws_security_access_cidr

  datalake_scale         = local.datalake_scale
  datalake_version       = var.datalake_version
  enable_ccm_tunnel      = var.enable_ccm_tunnel
  enable_raz             = var.enable_raz
  multiaz                = var.multiaz
  freeipa_instances      = var.freeipa_instances
  workload_analytics     = var.workload_analytics
  report_deployment_logs = var.report_deployment_logs
  endpoint_access_scheme = local.endpoint_access_scheme

  environment_async_creation  = var.environment_async_creation
  environment_polling_timeout = var.environment_polling_timeout
  datalake_async_creation     = var.datalake_async_creation
  datalake_polling_timeout    = var.datalake_polling_timeout

  region            = var.region
  vpc_id            = var.aws_vpc_id
  public_subnet_ids = var.aws_public_subnet_ids
  # private_subnet_ids = var.aws_private_subnet_ids
  subnets_for_cdp = local.aws_subnets_for_cdp
  # One of key settings below need to be set
  keypair_name    = var.keypair_name
  public_key_text = var.public_key_text

  data_storage_location   = var.data_storage_location
  log_storage_location    = var.log_storage_location
  backup_storage_location = var.backup_storage_location

  xaccount_role_arn       = var.aws_xaccount_role_arn
  datalake_admin_role_arn = var.aws_datalake_admin_role_arn
  ranger_audit_role_arn   = var.aws_ranger_audit_role_arn

  idbroker_instance_profile_arn = var.aws_idbroker_instance_profile_arn
  log_instance_profile_arn      = var.aws_log_instance_profile_arn

  # Optional parameters defaulting to null
  freeipa_catalog       = var.freeipa_catalog
  freeipa_image_id      = var.freeipa_image_id
  freeipa_instance_type = var.freeipa_instance_type
  freeipa_recipes       = var.freeipa_recipes

  encryption_key_arn = var.encryption_key_arn

  proxy_config_name   = var.proxy_config_name
  s3_guard_table_name = var.s3_guard_table_name

  datalake_custom_instance_groups = var.datalake_custom_instance_groups
  datalake_image                  = var.datalake_image
  datalake_java_version           = var.datalake_java_version
  datalake_recipes                = var.datalake_recipes
}

# ------- Call sub-module for Azure Deployment -------
module "cdp_on_azure" {
  count = (var.infra_type == "azure") ? 1 : 0

  source = "./modules/azure"

  tags = local.env_tags

  environment_name              = local.environment_name
  datalake_name                 = local.datalake_name
  create_cdp_credential         = var.create_cdp_credential
  cdp_xacccount_credential_name = local.cdp_xacccount_credential_name
  cdp_admin_group_name          = local.cdp_admin_group_name
  cdp_user_group_name           = local.cdp_user_group_name

  security_group_default_uri = var.azure_security_group_default_uri
  security_group_knox_uri    = var.azure_security_group_knox_uri
  security_access_cidr       = var.azure_security_access_cidr

  datalake_scale         = local.datalake_scale
  datalake_version       = var.datalake_version
  enable_ccm_tunnel      = var.enable_ccm_tunnel
  enable_raz             = var.enable_raz
  multiaz                = var.multiaz
  freeipa_instances      = var.freeipa_instances
  workload_analytics     = var.workload_analytics
  report_deployment_logs = var.report_deployment_logs
  endpoint_access_scheme = local.endpoint_access_scheme

  environment_async_creation  = var.environment_async_creation
  environment_polling_timeout = var.environment_polling_timeout
  datalake_async_creation     = var.datalake_async_creation
  datalake_polling_timeout    = var.datalake_polling_timeout

  use_single_resource_group = var.use_single_resource_group
  use_public_ips            = local.use_public_ips

  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id

  region                                     = var.region
  resource_group_name                        = var.azure_resource_group_name
  vnet_name                                  = var.azure_vnet_name
  cdp_subnet_names                           = var.azure_cdp_subnet_names
  cdp_gateway_subnet_names                   = var.azure_cdp_gateway_subnet_names
  cdp_flexible_server_delegated_subnet_names = var.azure_cdp_flexible_server_delegated_subnet_names
  public_key_text                            = var.public_key_text

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

  # Optional parameters defaulting to null
  freeipa_catalog       = var.freeipa_catalog
  freeipa_image_id      = var.freeipa_image_id
  freeipa_instance_type = var.freeipa_instance_type
  freeipa_recipes       = var.freeipa_recipes

  enable_outbound_load_balancer = var.enable_outbound_load_balancer

  encryption_key_resource_group_name = var.encryption_key_resource_group_name
  encryption_key_url                 = var.encryption_key_url
  encryption_at_host                 = var.encryption_at_host

  azure_aks_private_dns_zone_id      = var.azure_aks_private_dns_zone_id
  azure_database_private_dns_zone_id = var.azure_database_private_dns_zone_id
  create_private_endpoints           = var.azure_create_private_endpoints

  proxy_config_name = var.proxy_config_name

  datalake_image        = var.datalake_image
  datalake_java_version = var.datalake_java_version
  datalake_recipes      = var.datalake_recipes
}

# ------- Call sub-module for GCP Deployment -------
module "cdp_on_gcp" {
  count = (var.infra_type == "gcp") ? 1 : 0

  source = "./modules/gcp"

  tags = local.env_tags

  environment_name              = local.environment_name
  datalake_name                 = local.datalake_name
  create_cdp_credential         = var.create_cdp_credential
  cdp_xacccount_credential_name = local.cdp_xacccount_credential_name
  cdp_admin_group_name          = local.cdp_admin_group_name
  cdp_user_group_name           = local.cdp_user_group_name

  firewall_default_id = var.gcp_firewall_default_id
  firewall_knox_id    = var.gcp_firewall_knox_id

  datalake_scale    = local.datalake_scale
  datalake_version  = var.datalake_version
  enable_ccm_tunnel = var.enable_ccm_tunnel

  freeipa_instances     = var.freeipa_instances
  freeipa_instance_type = var.freeipa_instance_type
  freeipa_recipes       = var.freeipa_recipes

  workload_analytics     = var.workload_analytics
  report_deployment_logs = var.report_deployment_logs
  endpoint_access_scheme = local.endpoint_access_scheme

  environment_async_creation  = var.environment_async_creation
  environment_polling_timeout = var.environment_polling_timeout
  datalake_async_creation     = var.datalake_async_creation
  datalake_polling_timeout    = var.datalake_polling_timeout

  use_public_ips = local.use_public_ips

  project_id = var.gcp_project_id

  region           = var.region
  network_name     = var.gcp_network_name
  cdp_subnet_names = var.gcp_cdp_subnet_names
  public_key_text  = var.public_key_text

  data_storage_location   = var.data_storage_location
  log_storage_location    = var.log_storage_location
  backup_storage_location = var.backup_storage_location

  xaccount_service_account_private_key = var.gcp_xaccount_service_account_private_key

  proxy_config_name = var.proxy_config_name

  encryption_key                       = var.gcp_encryption_key
  idbroker_service_account_email       = var.gcp_idbroker_service_account_email
  ranger_audit_service_account_email   = var.gcp_ranger_audit_service_account_email
  datalake_admin_service_account_email = var.gcp_datalake_admin_service_account_email
  log_service_account_email            = var.gcp_log_service_account_email

  datalake_custom_instance_groups = var.datalake_custom_instance_groups
  datalake_image                  = var.datalake_image
  datalake_java_version           = var.datalake_java_version
  datalake_recipes                = var.datalake_recipes

}
