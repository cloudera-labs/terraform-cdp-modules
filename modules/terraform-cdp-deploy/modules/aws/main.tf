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

# Deployment and creation of CDP resources using Ansible Playbook called by TF local-exec

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
    plat__env_multiaz               = var.multiaz
    plat__env_freeipa_instances     = var.freeipa_instances
    plat__workload_analytics        = var.workload_analytics
    plat__tags                      = jsonencode(var.tags)

    # CDP settings
    plat__cdp_profile              = var.cdp_profile
    plat__cdp_control_plane_region = var.cdp_control_plane_region

    # CSP settings
    plat__infra_type = "aws"
    plat__region     = var.region

    plat__aws_vpc_id             = var.vpc_id
    plat__aws_public_subnet_ids  = jsonencode(var.public_subnet_ids)
    plat__aws_private_subnet_ids = jsonencode(var.private_subnet_ids)
    plat__aws_subnets_for_cdp    = jsonencode(var.subnets_for_cdp)

    plat__aws_storage_location = var.data_storage_location
    plat__aws_log_location     = var.log_storage_location
    plat__aws_backup_location  = var.backup_storage_location

    plat__public_key_id                 = var.keypair_name
    plat__aws_security_group_default_id = var.security_group_default_id
    plat__aws_security_group_knox_id    = var.security_group_knox_id

    plat__aws_datalake_admin_role_arn = var.datalake_admin_role_arn
    plat__aws_ranger_audit_role_arn   = var.ranger_audit_role_arn
    plat__aws_xaccount_role_arn       = var.xaccount_role_arn

    plat__aws_log_instance_profile_arn      = var.log_instance_profile_arn
    plat__aws_idbroker_instance_profile_arn = var.idbroker_instance_profile_arn
    }
  )
  filename = "cdp_config.yml"
}

# ------- Create CDP Deployment -------
resource "null_resource" "cdp_deployment" {

  # Setup of CDP environment using playbook_setup_cdp.yml.yml Ansible Playbook
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
