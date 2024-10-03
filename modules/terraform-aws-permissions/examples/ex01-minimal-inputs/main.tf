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

terraform {
  required_version = ">= 1.5.7"
  required_providers {
    cdp = {
      source  = "cloudera/cdp"
      version = ">= 0.6.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.30"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "ex01_minimal_inputs" {
  source = "../.."

  tags = var.tags

  # Policy documents from CDP TF Provider cred pre-reqs
  idbroker_policy_doc             = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Idbroker_Assumer"])
  data_bucket_access_policy_doc   = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Bucket_Access"])
  log_bucket_access_policy_doc    = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Bucket_Access"])
  backup_bucket_access_policy_doc = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Bucket_Access"])
  datalake_admin_s3_policy_doc    = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Datalake_Admin"])
  datalake_backup_policy_doc      = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Datalake_Backup"])
  datalake_restore_policy_doc     = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Datalake_Restore"])
  log_data_access_policy_doc      = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Log_Policy"])
  ranger_audit_s3_policy_doc      = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Ranger_Audit"])

  data_storage_bucket   = var.data_storage_bucket
  log_storage_bucket    = var.log_storage_bucket
  backup_storage_bucket = var.backup_storage_bucket

  storage_location_base = "${var.data_storage_bucket}/data"
  log_location_base     = "${var.log_storage_bucket}/logs"
  backup_location_base  = "${var.backup_storage_bucket}/backups"

  idbroker_policy_name             = "${var.env_prefix}-idbroker-policy"
  log_data_access_policy_name      = "${var.env_prefix}-logs-policy"
  ranger_audit_s3_policy_name      = "${var.env_prefix}-audit-policy"
  datalake_admin_s3_policy_name    = "${var.env_prefix}-dladmin-policy"
  data_bucket_access_policy_name   = "${var.env_prefix}-data-bucket-access-policy"
  log_bucket_access_policy_name    = "${var.env_prefix}-log-bucket-access-policy"
  backup_bucket_access_policy_name = "${var.env_prefix}-backup-bucket-access-policy"
  datalake_backup_policy_name      = "${var.env_prefix}-datalake-backup-policy"
  datalake_restore_policy_name     = "${var.env_prefix}-datalake-restore-policy"

  idbroker_role_name       = "${var.env_prefix}-idbroker-role"
  log_role_name            = "${var.env_prefix}-logs-role"
  datalake_admin_role_name = "${var.env_prefix}-dladmin-role"
  ranger_audit_role_name   = "${var.env_prefix}-audit-role"

}

# Use the CDP Terraform Provider to find the xaccount account and external ids
data "cdp_environments_aws_credential_prerequisites" "cdp_prereqs" {}
