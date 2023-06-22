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

  count = var.deploy_cdp == true ? 1 : 0

  content = templatefile("${path.module}/templates/cdp_config.yml.tpl", {
    # CDP environment & DL settings
    plat__env_name                  = "${var.env_prefix}-cdp-env"
    plat__datalake_name             = "${var.env_prefix}-az-dl"
    plat__datalake_scale            = local.datalake_scale
    plat__datalake_version          = var.datalake_version
    plat__xacccount_credential_name = "${var.env_prefix}-xaccount-cred"
    plat__cdp_iam_admin_group_name  = "${var.env_prefix}-cdp-admin-group"
    plat__cdp_iam_user_group_name   = "${var.env_prefix}-cdp-user-group"
    plat__tunnel                    = var.enable_ccm_tunnel
    plat__enable_raz                = var.enable_raz
    plat__use_single_resource_group = var.use_single_resource_group
    plat__use_public_ips            = (var.deployment_template == "public")
    plat__env_freeipa_instances     = var.freeipa_instances
    plat__workload_analytics        = var.workload_analytics
    plat__tags                      = jsonencode(local.env_tags)

    # CDP settings
    plat__cdp_profile              = var.cdp_profile
    plat__cdp_control_plane_region = var.cdp_control_plane_region

    # CSP settings
    plat__infra_type = var.infra_type
    plat__region     = var.azure_region

    plat__azure_subscription_id = data.azurerm_subscription.current.subscription_id
    plat__azure_tenant_id       = data.azurerm_subscription.current.tenant_id

    plat__azure_resourcegroup_name   = azurerm_resource_group.cdp_rmgp.name
    plat__azure_vnet_id              = local.vnet_id
    plat__azure_subnet_ids_for_cdp   = jsonencode(local.subnet_ids)
    plat__azure_subnet_names_for_cdp = jsonencode(local.subnet_names)

    plat__azure_storage_location = "abfs://${azurerm_storage_container.cdp_data_storage.name}@${azurerm_storage_container.cdp_data_storage.storage_account_name}.dfs.core.windows.net"
    plat__azure_log_location     = "abfs://${azurerm_storage_container.cdp_log_storage.name}@${azurerm_storage_container.cdp_log_storage.storage_account_name}.dfs.core.windows.net"
    plat__azure_backup_location  = "abfs://${azurerm_storage_container.cdp_backup_storage.name}@${azurerm_storage_container.cdp_backup_storage.storage_account_name}.dfs.core.windows.net"

    plat__public_key_text                  = var.public_key_text
    plat__azure_security_group_default_uri = azurerm_network_security_group.cdp_default_sg.id
    plat__azure_security_group_knox_uri    = azurerm_network_security_group.cdp_knox_sg.id

    plat__azure_xaccount_app_uuid  = azuread_application.cdp_xaccount_app.application_id
    plat__azure_xaccount_app_pword = azuread_application_password.cdp_xaccount_app_password.value

    plat__azure_idbroker_identity_id      = azurerm_user_assigned_identity.cdp_idbroker.id
    plat__azure_datalakeadmin_identity_id = azurerm_user_assigned_identity.cdp_datalake_admin.id
    plat__azure_ranger_audit_identity_id  = azurerm_user_assigned_identity.cdp_ranger_audit_data_access.id
    plat__azure_log_identity_id           = azurerm_user_assigned_identity.cdp_log_data_access.id
    plat__azure_raz_identity_id           = (var.enable_raz) ? azurerm_user_assigned_identity.cdp_raz[0].id : ""

    }
  )
  filename = "cdp_config.yml"
}

# ------- Create CDP Deployment -------
resource "null_resource" "cdp_deployment" {

  count = var.deploy_cdp == true ? 1 : 0

  # Setup of CDP environment using playbook_setup_cdp.yml Ansible Playbook
  provisioner "local-exec" {
    command = "ansible-playbook -vvv -e '@cdp_config.yml' ${path.module}/playbook_setup_cdp.yml"
  }

  # Deletion of CDP environment using playbook_teardown_cdp.yml Ansible Playbook
  provisioner "local-exec" {
    when    = destroy
    command = "ansible-playbook -vvv -e '@cdp_config.yml' ${path.module}/playbook_teardown_cdp.yml"
  }

  # Depends on * resources to ensure CDP environment is setup/deleted after/before all pre-reqs.
  # TODO: Need to investigate further to see if this list can be trimmed.
  depends_on = [
    local_file.cdp_deployment_template,
    azuread_application.cdp_xaccount_app,
    azurerm_network_security_group.cdp_default_sg,
    azurerm_network_security_group.cdp_knox_sg,
    azurerm_network_security_rule.cdp_default_sg_ingress_extra_access,
    azurerm_network_security_rule.cdp_knox_sg_ingress_extra_access,
    azurerm_resource_group.cdp_rmgp,
    random_id.bucket_suffix,
    azurerm_storage_account.cdp_storage_locations,
    azurerm_storage_container.cdp_backup_storage,
    azurerm_storage_container.cdp_data_storage,
    azurerm_storage_container.cdp_log_storage,
    module.azure_cdp_vnet,
    azurerm_user_assigned_identity.cdp_datalake_admin,
    azurerm_user_assigned_identity.cdp_idbroker,
    azurerm_user_assigned_identity.cdp_log_data_access,
    azurerm_user_assigned_identity.cdp_ranger_audit_data_access,
    azurerm_user_assigned_identity.cdp_raz,
    azurerm_role_assignment.cdp_datalake_admin_backup_container_assign,
    azurerm_role_assignment.cdp_datalake_admin_data_container_assign,
    azurerm_role_assignment.cdp_datalake_admin_log_container_assign,
    azurerm_role_assignment.cdp_idbroker_assign,
    azurerm_role_assignment.cdp_log_data_access_backup_container_assign,
    azurerm_role_assignment.cdp_log_data_access_log_container_assign,
    azurerm_role_assignment.cdp_ranger_audit_backup_container_assign,
    azurerm_role_assignment.cdp_ranger_audit_data_container_assign,
    azurerm_role_assignment.cdp_ranger_audit_log_container_assign,
    azurerm_role_assignment.cdp_raz_assign,
    azurerm_role_assignment.cdp_xaccount_role

  ]
}
