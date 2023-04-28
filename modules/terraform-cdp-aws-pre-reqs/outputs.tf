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

# CDP environment & DL settings
output "cdp_env_name" {
  value = "${var.env_prefix}-cdp-env"

  description = "CDP environment name"
}

output "cdp_datalake_name" {
  value = "${var.env_prefix}-aws-dl"

  description = "CDP Datalake name"
}

output "cdp_xacccount_credential_name" {
  value = "${var.env_prefix}-xaccount-cred"

  description = "Cross Account credential name"
}


output "cdp_iam_admin_group_name" {
  value = "${var.env_prefix}-cdp-admin-group"

  description = "CDP IAM admin group name"
}

output "cdp_iam_user_group_name" {
  value = "${var.env_prefix}-cdp-user-group"

  description = "CDP IAM user group name"
}

output "cdp_tunnel_enabled" {
  value = (var.deployment_template == "public") ? "false" : "true"

  description = "Flag to enable SSH tunnelling for the CDP environment"
}

output "cdp_endpoint_access_scheme" {
  value = (var.deployment_template == "semi-private") ? "PUBLIC" : "PRIVATE"

  description = "The scheme for the workload endpoint gateway. `PUBLIC` creates an external endpoint that can be accessed over the Internet. `PRIVATE` restricts the traffic to be internal to the VPC / Vnet. Relevant in Private Networks."
}

output "cdp_enable_raz" {
  value = var.enable_raz

  description = "Flag to enable Ranger Authorization Service (RAZ) for the CDP environment"
}

output "cdp_enable_multiaz" {
  value = var.multiaz

  description = "Flag to specify if multi-AZ deployment is enabled for the CDP environment"
}

output "cdp_freeipa_instances" {
  value = var.freeipa_instances

  description = "Number of instances for the FreeIPA service of the environment"
}

output "cdp_workload_analytics" {
  value = var.workload_analytics

  description = "Flag to enable Workload Analytics"
}

output "tags" {
  value = local.env_tags

  description = "Tags associated with the environment and its resources"
}

# CDP settings
output "cdp_profile" {
  value = var.cdp_profile

  description = "Profile for CDP credentials"
}

output "cdp_control_plane_region" {
  value = var.cdp_control_plane_region

  description = "CDP Control Plane region"
}

# CSP settings
output "infra_type" {
  value = var.infra_type

  description = "Cloud Service Provider type"
}

output "aws_region" {
  value = var.aws_region

  description = "Cloud provider region of the Environment"

}

output "aws_vpc_id" {
  value = local.vpc_id

  description = "AWS VPC ID"
}

output "aws_default_route_table_id" {
  value = local.default_route_table_id

  description = "AWS default route table ID"
}

output "aws_public_route_table_ids" {
  value = local.public_route_table_ids

  description = "AWS public route table IDs"
}

output "aws_private_route_table_ids" {
  value = local.private_route_table_ids

  description = "AWS private route table IDs"
}

output "aws_public_subnet_ids" {
  value = local.public_subnet_ids

  description = "AWS public subnet IDs"
}

output "aws_private_subnet_ids" {
  value = local.private_subnet_ids

  description = "AWS private subnet IDs"
}

output "aws_storage_location" {
  value = "s3a://${local.data_storage.data_storage_bucket}${local.storage_suffix}"

  description = "AWS data storage location"
}

output "aws_log_location" {
  value = "s3a://${local.log_storage.log_storage_bucket}${local.storage_suffix}"

  description = "AWS log storage location"
}

output "aws_backup_location" {
  value = "s3a://${local.backup_storage.backup_storage_bucket}${local.storage_suffix}"

  description = "AWS backup storage location"
}

output "public_key_id" {
  value = var.aws_key_pair

  description = "Keypair name in Cloud Service Provider"
}

output "aws_security_group_default_id" {
  value = aws_security_group.cdp_default_sg.id

  description = "AWS security group id for default CDP SG"
}

output "aws_security_group_knox_id" {
  value = aws_security_group.cdp_knox_sg.id

  description = "AWS security group id for Knox CDP SG"
}

output "aws_datalake_admin_role_arn" {
  value = aws_iam_role.cdp_datalake_admin_role.arn

  description = "Datalake Admin role ARN"
}

output "aws_ranger_audit_role_arn" {
  value = aws_iam_role.cdp_ranger_audit_role.arn

  description = "Ranger Audit role ARN"
}

output "aws_xaccount_role_arn" {
  value = aws_iam_role.cdp_xaccount_role.arn

  description = "Cross Account role ARN"
}

output "aws_log_instance_profile_arn" {
  value = aws_iam_instance_profile.cdp_log_role_instance_profile.arn

  description = "Log instance profile ARN"
}

output "aws_idbroker_instance_profile_arn" {
  value = aws_iam_instance_profile.cdp_idbroker_role_instance_profile.arn

  description = "IDBroker instance profile ARN"
}
