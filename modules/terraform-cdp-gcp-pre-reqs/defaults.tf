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
  vpc_name = coalesce(var.vpc_name, "${var.env_prefix}-net")

  # VPC Peering for CloudSQL
  managed_services_global_address_name = coalesce(var.managed_services_global_address_name, "${var.env_prefix}-svc-address")

  # Firewall
  firewall_internal_name = coalesce(var.firewall_internal_name, "${var.env_prefix}-allow-internal-fw")
  firewall_default_name  = coalesce(var.firewall_default_name, "${var.env_prefix}-default-fw")
  firewall_knox_name     = coalesce(var.firewall_knox_name, "${var.env_prefix}-knox-fw")

  cdp_vpc_name = (var.create_vpc ?
  module.gcp_cdp_vpc[0].vpc_name : var.cdp_vpc_name)

  cdp_subnet_names = (var.create_vpc ?
  module.gcp_cdp_vpc[0].vpc_cdp_subnet_names : var.cdp_subnet_names)

  cdp_subnet_private_ip_google_access = contains(["public", "private"], var.deployment_template) ? true : false

  compute_router_name = coalesce(var.compute_router_name, "${var.env_prefix}-router")

  compute_router_nat_name = coalesce(var.compute_router_nat_name, "${var.env_prefix}-nat")

  # ------- Storage Resources -------
  storage_suffix = var.random_id_for_bucket ? one(random_id.bucket_suffix).hex : ""

  # By default the storage bucket region is var.gcp_region
  bucket_storage_region = coalesce(var.bucket_storage_region, var.gcp_region)

  # Default storage bucket is based on env_prefix
  default_storage_name = "${var.env_prefix}-buk"

  data_storage_bucket = coalesce(var.data_storage_bucket, "${local.default_storage_name}-data")

  log_storage_bucket = coalesce(var.log_storage_bucket, "${local.default_storage_name}-logs")

  backup_storage_bucket = coalesce(var.backup_storage_bucket, "${local.default_storage_name}-backup")

  # ------- Authz Resources -------

  # Cross Account
  xaccount_service_account_name = coalesce(var.xaccount_service_account_name, "${var.env_prefix}-xaccount-sa")
  xaccount_service_account_id   = replace(local.xaccount_service_account_name, "/[_]/", "-")

  # Custom Roles
  # ...Log data access role
  log_data_access_custom_role_name = coalesce(var.log_data_access_custom_role_name, "${var.env_prefix}-log-role")
  log_data_access_custom_role_id   = replace(local.log_data_access_custom_role_name, "/[-]/", "_")

  # ...Ranger Audit and Datalake Admin Role
  datalake_admin_custom_role_name = coalesce(var.datalake_admin_custom_role_name, "${var.env_prefix}-data-role")
  datalake_admin_custom_role_id   = replace(local.datalake_admin_custom_role_name, "/[-]/", "_")

  # ...IDBroker Role
  idbroker_custom_role_name = coalesce(var.idbroker_custom_role_name, "${var.env_prefix}-idbroker-role")
  idbroker_custom_role_id   = replace(local.idbroker_custom_role_name, "/[-]/", "_")

  # Operational Service Accounts
  # ...Log Service Account
  log_service_account_name = coalesce(var.log_service_account_name, "${var.env_prefix}-log-sa")
  log_service_account_id   = replace(local.log_service_account_name, "/[_]/", "-")

  # ...Datalake Admin Service Account
  datalake_admin_service_account_name = coalesce(var.datalake_admin_service_account_name, "${var.env_prefix}-dladmin-sa")
  datalake_admin_service_account_id   = replace(local.datalake_admin_service_account_name, "/[_]/", "-")

  # ...Ranger Audit Service Account
  ranger_audit_service_account_name = coalesce(var.ranger_audit_service_account_name, "${var.env_prefix}-rgraudit-sa")
  ranger_audit_service_account_id   = replace(local.ranger_audit_service_account_name, "/[_]/", "-")

  # ...IDBroker Service Account
  idbroker_service_account_name = coalesce(var.idbroker_service_account_name, "${var.env_prefix}-idbroker-sa")
  idbroker_service_account_id   = replace(local.idbroker_service_account_name, "/[_]/", "-")

}
