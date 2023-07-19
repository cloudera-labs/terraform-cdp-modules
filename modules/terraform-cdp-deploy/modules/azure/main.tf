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

# ------- Create Configuration file for CDP Deployment via Ansible -------
resource "local_file" "cdp_deployment_template" {

  content = templatefile("${path.module}/templates/cdp_config.yml.tpl", {
    # CDP environment & DL settings
    plat__env_name                  = var.environment_name
    plat__datalake_name             = var.datalake_name
    plat__datalake_scale            = var.datalake_scale
    plat__datalake_version          = var.datalake_version
    plat__xacccount_credential_name = var.cdp_xacccount_credential_name
    plat__cdp_iam_admin_group_name  = var.cdp_admin_group_name
    plat__cdp_iam_user_group_name   = var.cdp_user_group_name
    plat__tunnel                    = var.enable_ccm_tunnel
    plat__endpoint_access_scheme    = var.endpoint_access_scheme
    plat__enable_raz                = var.enable_raz
    plat__use_single_resource_group = var.use_single_resource_group
    plat__use_public_ips            = var.use_public_ips
    plat__env_freeipa_instances     = var.freeipa_instances
    plat__workload_analytics        = var.workload_analytics
    plat__tags                      = jsonencode(var.tags)

    # CDP settings
    plat__cdp_profile              = var.cdp_profile
    plat__cdp_control_plane_region = var.cdp_control_plane_region

    # # CSP settings
    plat__infra_type = "azure"
    plat__region     = var.region

    plat__azure_subscription_id = var.subscription_id
    plat__azure_tenant_id       = var.tenant_id

    plat__azure_resourcegroup_name       = var.resource_group_name
    plat__azure_vnet_name                = var.vnet_name
    plat__azure_subnet_names_for_cdp     = jsonencode(var.cdp_subnet_names)
    plat__azure_subnet_names_for_gateway = jsonencode(var.cdp_gateway_subnet_names)

    plat__azure_storage_location = var.data_storage_location
    plat__azure_log_location     = var.log_storage_location
    plat__azure_backup_location  = var.backup_storage_location

    plat__public_key_text                  = var.public_key_text
    plat__azure_security_group_default_uri = var.security_group_default_uri
    plat__azure_security_group_knox_uri    = var.security_group_knox_uri

    plat__azure_xaccount_app_uuid  = var.xaccount_app_uuid
    plat__azure_xaccount_app_pword = var.xaccount_app_pword

    plat__azure_idbroker_identity_id      = var.idbroker_identity_id
    plat__azure_datalakeadmin_identity_id = var.datalakeadmin_identity_id
    plat__azure_ranger_audit_identity_id  = var.ranger_audit_identity_id
    plat__azure_log_identity_id           = var.log_identity_id
    plat__azure_raz_identity_id           = var.raz_identity_id

    }
  )
  filename = "cdp_config.yml"
}

# ------- Create CDP Deployment -------
resource "null_resource" "cdp_deployment" {

  # Setup of CDP environment using playbook_setup_cdp.yml Ansible Playbook
  provisioner "local-exec" {
    command = "ansible-playbook -vvv -e '@cdp_config.yml' ${path.module}/playbook_setup_cdp.yml"
  }

  # Deletion of CDP environment using playbook_teardown_cdp.yml Ansible Playbook
  provisioner "local-exec" {
    when    = destroy
    command = "ansible-playbook -vvv -e '@cdp_config.yml' ${path.module}/playbook_teardown_cdp.yml"
  }

  depends_on = [
    local_file.cdp_deployment_template,
  ]
}
