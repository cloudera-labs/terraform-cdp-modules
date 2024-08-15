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

locals {

  # ------- Global settings -------
  caller_account_id = data.aws_caller_identity.current.account_id

  # ------- Policies -------
  # Process placeholders in policy documents
  
  # Bucket Access Policy
  # ...process placeholders in the policy doc
  data_bucket_access_policy_doc_processed = replace(
    replace(
    var.data_bucket_access_policy_doc, "$${ARN_PARTITION}", var.arn_partition),
  "$${DATALAKE_BUCKET}", "${var.data_storage_bucket}")
  
  log_bucket_access_policy_doc_processed = replace(
    replace(
    var.log_bucket_access_policy_doc, "$${ARN_PARTITION}", var.arn_partition),
  "$${DATALAKE_BUCKET}", "${var.log_storage_bucket}")
  
  backup_bucket_access_policy_doc_processed = replace(
    replace(
    var.backup_bucket_access_policy_doc, "$${ARN_PARTITION}", var.arn_partition),
  "$${DATALAKE_BUCKET}", "${var.backup_storage_bucket}")
  
  # ...then assign either input or processed policy doc to var used in resource
  data_bucket_access_policy_doc = var.process_policy_placeholders ? local.data_bucket_access_policy_doc_processed : var.data_bucket_access_policy_doc
  log_bucket_access_policy_doc = var.process_policy_placeholders ? local.log_bucket_access_policy_doc_processed : var.log_bucket_access_policy_doc
  backup_bucket_access_policy_doc = var.process_policy_placeholders ? local.backup_bucket_access_policy_doc_processed : var.backup_bucket_access_policy_doc

  # Datalake Admin
  # ...process placeholders in the policy doc
  datalake_admin_s3_policy_doc_processed = replace(
    replace(
    var.datalake_admin_s3_policy_doc, "$${ARN_PARTITION}", var.arn_partition),
  "$${STORAGE_LOCATION_BASE}", var.storage_location_base)
  # ...then assign either input or processed policy doc to var used in resource
  datalake_admin_s3_policy_doc = var.process_policy_placeholders ? local.datalake_admin_s3_policy_doc_processed : var.datalake_admin_s3_policy_doc

  # Backup policy
  # ...process placeholders in the policy doc
  datalake_backup_policy_doc_processed = replace(
    replace(
    var.datalake_backup_policy_doc, "$${ARN_PARTITION}", var.arn_partition),
  "$${BACKUP_LOCATION_BASE}", var.backup_location_base)
  # ...then assign either input or processed policy doc to var used in resource
  datalake_backup_policy_doc = var.process_policy_placeholders ? local.datalake_backup_policy_doc_processed : var.datalake_backup_policy_doc

  # Restore policy
  # ...process placeholders in the policy doc
  datalake_restore_policy_doc_processed = replace(
    replace(
    replace(
    var.datalake_restore_policy_doc, "$${ARN_PARTITION}", var.arn_partition),
  "$${BACKUP_LOCATION_BASE}", var.backup_location_base),
  "$${BACKUP_BUCKET}", var.backup_storage_bucket)
  # ...then assign either input or processed policy doc to var used in resource
  datalake_restore_policy_doc = var.process_policy_placeholders ? local.datalake_restore_policy_doc_processed : var.datalake_restore_policy_doc

  # Log policy
  # ...process placeholders in the policy doc
  log_data_access_policy_doc_processed = replace(
    replace(
      replace(
      var.log_data_access_policy_doc, "$${ARN_PARTITION}", var.arn_partition),
    "$${LOGS_BUCKET}", var.log_storage_bucket),
  "$${LOGS_LOCATION_BASE}", var.log_location_base)
  # ...then assign either input or processed policy doc to var used in resource
  log_data_access_policy_doc = var.process_policy_placeholders ? local.log_data_access_policy_doc_processed : var.log_data_access_policy_doc

  # Ranger Audit
  # ...process placeholders in the policy doc
  ranger_audit_s3_policy_doc_processed = replace(
    replace(
      replace(
      var.ranger_audit_s3_policy_doc, "$${ARN_PARTITION}", var.arn_partition),
    "$${STORAGE_LOCATION_BASE}", var.storage_location_base),
  "$${DATALAKE_BUCKET}", var.data_storage_bucket)
  # ...then assign either input or processed policy doc to var used in resource
  ranger_audit_s3_policy_doc = var.process_policy_placeholders ? local.ranger_audit_s3_policy_doc_processed : var.ranger_audit_s3_policy_doc

}