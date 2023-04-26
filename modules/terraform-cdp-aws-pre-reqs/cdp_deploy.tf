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

  count = var.deploy_cdp == true ? 1 : 0

  content = templatefile("${path.module}/templates/cdp_config.yml.tpl", {
    # CDP environment & DL settings
    plat__env_name                  = "${var.env_prefix}-cdp-env"
    plat__datalake_name             = "${var.env_prefix}-aws-dl"
    plat__datalake_scale            = local.datalake_scale
    plat__xacccount_credential_name = "${var.env_prefix}-xaccount-cred"
    plat__cdp_iam_admin_group_name  = "${var.env_prefix}-cdp-admin-group"
    plat__cdp_iam_user_group_name   = "${var.env_prefix}-cdp-user-group"
    plat__tunnel                    = var.enable_ccm_tunnel
    plat__endpoint_access_scheme    = (var.deployment_template == "semi-private") ? "PUBLIC" : "PRIVATE"
    plat__enable_raz                = var.enable_raz
    plat__env_multiaz               = var.multiaz
    plat__env_freeipa_instances     = var.freeipa_instances
    plat__workload_analytics        = var.workload_analytics
    plat__tags                      = jsonencode(local.env_tags)

    # CDP settings
    plat__cdp_profile              = var.cdp_profile
    plat__cdp_control_plane_region = var.cdp_control_plane_region

    # CSP settings
    plat__infra_type = var.infra_type
    plat__region     = var.aws_region

    plat__aws_vpc_id             = local.vpc_id
    plat__aws_public_subnet_ids  = jsonencode(local.public_subnet_ids)
    plat__aws_private_subnet_ids = jsonencode(local.private_subnet_ids)

    plat__aws_storage_location = "s3a://${local.data_storage.data_storage_bucket}${local.storage_suffix}"
    plat__aws_log_location     = "s3a://${local.log_storage.log_storage_bucket}${local.storage_suffix}/${local.log_storage.log_storage_object}"

    plat__public_key_id                 = var.aws_key_pair
    plat__aws_security_group_default_id = aws_security_group.cdp_default_sg.id
    plat__aws_security_group_knox_id    = aws_security_group.cdp_knox_sg.id

    plat__aws_datalake_admin_role_arn = aws_iam_role.cdp_datalake_admin_role.arn
    plat__aws_ranger_audit_role_arn   = aws_iam_role.cdp_ranger_audit_role.arn
    plat__aws_xaccount_role_arn       = aws_iam_role.cdp_xaccount_role.arn

    plat__aws_log_instance_profile_arn      = aws_iam_instance_profile.cdp_log_role_instance_profile.arn
    plat__aws_idbroker_instance_profile_arn = aws_iam_instance_profile.cdp_idbroker_role_instance_profile.arn
    }
  )
  filename = "cdp_config.yml"
}

# ------- Create CDP Deployment -------
resource "null_resource" "cdp_deployment" {

  count = var.deploy_cdp == true ? 1 : 0

  # Setup of CDP environment using playbook_setup_cdp.yml.yml Ansible Playbook
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
    module.aws_cdp_vpc,
    aws_security_group.cdp_default_sg,
    aws_security_group.cdp_knox_sg,
    random_id.bucket_suffix,
    aws_s3_bucket.cdp_storage_locations,
    aws_s3_object.cdp_data_storage_object,
    aws_s3_object.cdp_log_storage_object,
    aws_iam_policy.cdp_xaccount_policy,
    data.aws_iam_policy_document.cdp_idbroker_policy_doc,
    aws_iam_policy.cdp_idbroker_policy,
    aws_iam_policy.cdp_log_data_access_policy,
    aws_iam_policy.cdp_ranger_audit_s3_data_access_policy,
    aws_iam_policy.cdp_datalake_admin_s3_data_access_policy,
    aws_iam_policy.cdp_bucket_data_access_policy,
    data.aws_iam_policy_document.cdp_xaccount_role_policy_doc,
    aws_iam_role.cdp_xaccount_role,
    aws_iam_role_policy_attachment.cdp_xaccount_role_attach,
    data.aws_iam_policy_document.cdp_idbroker_role_policy_doc,
    aws_iam_role.cdp_idbroker_role,
    aws_iam_instance_profile.cdp_idbroker_role_instance_profile,
    aws_iam_role_policy_attachment.cdp_idbroker_role_attach1,
    aws_iam_role_policy_attachment.cdp_idbroker_role_attach2,
    data.aws_iam_policy_document.cdp_log_role_policy_doc,
    aws_iam_role.cdp_log_role,
    aws_iam_instance_profile.cdp_log_role_instance_profile,
    aws_iam_role_policy_attachment.cdp_log_role_attach1,
    aws_iam_role_policy_attachment.cdp_log_role_attach2,
    data.aws_iam_policy_document.cdp_datalake_admin_role_policy_doc,
    aws_iam_role.cdp_datalake_admin_role,
    aws_iam_instance_profile.cdp_datalake_admin_role_instance_profile,
    aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach1,
    aws_iam_role_policy_attachment.cdp_datalake_admin_role_attach2,
    data.aws_iam_policy_document.cdp_ranger_audit_role_policy_doc,
    aws_iam_role.cdp_ranger_audit_role,
    aws_iam_instance_profile.cdp_ranger_audit_role_instance_profile,
    aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach1,
    aws_iam_role_policy_attachment.cdp_ranger_audit_role_attach2
  ]
}
