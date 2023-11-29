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

# Find the AWS account details
data "aws_caller_identity" "current" {}

# Find details about S3 Gateway endpoint services
data "aws_vpc_endpoint_service" "gateway_endpoints" {
  for_each = var.create_vpc && var.create_vpc_endpoints ? toset(var.vpc_endpoint_gateway_services) : []

  service      = each.key
  service_type = "Gateway"
}

# Find details about S3 Gateway endpoint services
data "aws_vpc_endpoint_service" "interface_endpoints" {
  for_each = var.create_vpc && var.create_vpc_endpoints ? toset(var.vpc_endpoint_interface_services) : []

  service      = each.key
  service_type = "Interface"
}

# HTTP get request to download policy documents
# ..Cross Account Policy
data "http" "xaccount_account_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/CB-2.73.0/cloud-aws-common/src/main/resources/definitions/aws-cb-policy.json"
}

# ..CDP Log Data Access Policies
data "http" "log_data_access_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/CB-2.73.0/cloud-aws-common/src/main/resources/definitions/cdp/aws-cdp-log-policy.json"
}

# ..CDP ranger_audit_s3 Data Access Policies
data "http" "ranger_audit_s3_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/CB-2.73.0/cloud-aws-common/src/main/resources/definitions/cdp/aws-cdp-ranger-audit-s3-policy.json"
}

# ..CDP datalake_admin_s3 Data Access Policies
data "http" "datalake_admin_s3_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/CB-2.73.0/cloud-aws-common/src/main/resources/definitions/cdp/aws-cdp-datalake-admin-s3-policy.json"
}

# ..CDP bucket_access Data Access Policies
data "http" "bucket_access_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/CB-2.73.0/cloud-aws-common/src/main/resources/definitions/cdp/aws-cdp-bucket-access-policy.json"
}

# ..CDP Data Lake Backup Policies
data "http" "datalake_backup_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/CB-2.73.0/cloud-aws-cloudformation/src/main/resources/definitions/aws-datalake-backup-policy.json"
}

# ..CDP Data Lake Restore Policies
data "http" "datalake_restore_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/CB-2.73.0/cloud-aws-cloudformation/src/main/resources/definitions/aws-datalake-restore-policy.json"
}
