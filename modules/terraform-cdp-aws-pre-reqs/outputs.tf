# Copyright 2024 Cloudera, Inc. All Rights Reserved.
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

output "tags" {
  value = local.env_tags

  description = "Tags associated with the environment and its resources"
}

# CSP settings
output "aws_region" {
  value = var.aws_region

  description = "Cloud provider region of the Environment"

}

output "aws_vpc_id" {
  value = module.aws_cdp_vpc.vpc_id

  description = "AWS VPC ID"
}

output "aws_default_route_table_id" {
  value = module.aws_cdp_vpc.default_route_table

  description = "AWS default route table ID"
}

output "aws_public_route_table_ids" {
  value = module.aws_cdp_vpc.public_route_tables

  description = "AWS public route table IDs"
}

output "aws_private_route_table_ids" {
  value = module.aws_cdp_vpc.private_route_tables

  description = "AWS private route table IDs"
}

output "aws_public_subnet_ids" {
  value = module.aws_cdp_vpc.public_subnets

  description = "AWS public subnet IDs"
}

output "aws_private_subnet_ids" {
  value = module.aws_cdp_vpc.private_subnets

  description = "AWS private subnet IDs"
}

output "aws_vpc_subnets" {
  value = module.aws_cdp_vpc.vpc_subnets

  description = "List of subnets associated with the CDP VPC"
}

output "aws_data_storage_bucket" {
  value = "${local.data_storage.data_storage_bucket}${local.storage_suffix}"

  description = "AWS data storage bucket"
}

output "aws_data_storage_location" {
  value = "s3a://${local.data_storage.data_storage_bucket}${local.storage_suffix}/${local.data_storage.data_storage_object}"

  description = "AWS data storage location"
}

output "aws_data_storage_object" {
  value = local.data_storage.data_storage_object

  description = "AWS data storage object"
}

output "aws_log_storage_bucket" {
  value = "${local.log_storage.log_storage_bucket}${local.storage_suffix}"

  description = "AWS log storage bucket"
}

output "aws_log_storage_object" {
  value = local.log_storage.log_storage_object

  description = "AWS log storage object"
}

output "aws_log_storage_location" {
  value = "s3a://${local.log_storage.log_storage_bucket}${local.storage_suffix}/${local.log_storage.log_storage_object}"

  description = "AWS log storage location"
}

output "aws_backup_storage_bucket" {
  value = "${local.backup_storage.backup_storage_bucket}${local.storage_suffix}"

  description = "AWS backup storage bucket"
}

output "aws_backup_storage_object" {
  value = local.backup_storage.backup_storage_object

  description = "AWS backup storage object"
}
output "aws_backup_storage_location" {
  value = "s3a://${local.backup_storage.backup_storage_bucket}${local.storage_suffix}/${local.backup_storage.backup_storage_object}"

  description = "AWS backup storage location"
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
  value = module.aws_cdp_permissions.aws_datalake_admin_role_arn

  description = "Datalake Admin role ARN"
}

output "aws_ranger_audit_role_arn" {
  value = module.aws_cdp_permissions.aws_ranger_audit_role_arn

  description = "Ranger Audit role ARN"
}

output "aws_xaccount_role_arn" {
  value = aws_iam_role.cdp_xaccount_role.arn

  description = "Cross Account role ARN"
}

output "aws_xaccount_role_name" {
  value = aws_iam_role.cdp_xaccount_role.name

  description = "Cross Account role name"
}

output "aws_log_role_name" {
  value = module.aws_cdp_permissions.aws_log_role_name

  description = "Log role Name"
}

output "aws_idbroker_role_name" {
  value = module.aws_cdp_permissions.aws_idbroker_role_name

  description = "IDBroker role Name"
}

output "aws_datalake_admin_role_name" {
  value = module.aws_cdp_permissions.aws_datalake_admin_role_name

  description = "Datalake Admin role Name"
}

output "aws_ranger_audit_role_name" {
  value = module.aws_cdp_permissions.aws_ranger_audit_role_name

  description = "Ranger Audit role Name"
}

output "aws_log_instance_profile_arn" {
  value = module.aws_cdp_permissions.aws_log_instance_profile_arn

  description = "Log instance profile ARN"
}

output "aws_idbroker_instance_profile_arn" {
  value = module.aws_cdp_permissions.aws_idbroker_instance_profile_arn

  description = "IDBroker instance profile ARN"
}
