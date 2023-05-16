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

# Find details of the AWS vpc
data "aws_vpc" "cdp_vpc" {
  id = local.vpc_id
}

data "aws_subnets" "cdp_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }

  # Postcondition to verify subnets are part of VPC
    lifecycle {
    postcondition {
      condition = (length(setsubtract(local.public_subnet_ids, self.ids)) == 0) && (length(setsubtract(local.private_subnet_ids, self.ids)) == 0)
      error_message = "One or more of the provided subnets - ${join(",",setsubtract(concat(local.public_subnet_ids,local.private_subnet_ids), self.ids))} - are not part of VPC ${local.vpc_id}"
    }
  }
}

# HTTP get request to download policy documents
# ..Cross Account Policy
data "http" "xaccount_account_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/master/cloud-aws-common/src/main/resources/definitions/aws-cb-policy.json"
}

# ..CDP Log Data Access Policies
data "http" "log_data_access_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/master/cloud-aws-common/src/main/resources/definitions/cdp/aws-cdp-log-policy.json"
}

# ..CDP ranger_audit_s3 Data Access Policies
data "http" "ranger_audit_s3_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/master/cloud-aws-common/src/main/resources/definitions/cdp/aws-cdp-ranger-audit-s3-policy.json"
}

# ..CDP datalake_admin_s3 Data Access Policies
data "http" "datalake_admin_s3_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/master/cloud-aws-common/src/main/resources/definitions/cdp/aws-cdp-datalake-admin-s3-policy.json"
}

# ..CDP bucket_access Data Access Policies
data "http" "bucket_access_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/master/cloud-aws-common/src/main/resources/definitions/cdp/aws-cdp-bucket-access-policy.json"
}

# ..CDP Data Lake Backup Policies
data "http" "datalake_backup_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/master/cloud-aws-cloudformation/src/main/resources/definitions/aws-datalake-backup-policy.json"
}

# ..CDP Data Lake Restore Policies
data "http" "datalake_restore_policy_doc" {
  url = "https://raw.githubusercontent.com/hortonworks/cloudbreak/master/cloud-aws-cloudformation/src/main/resources/definitions/aws-datalake-restore-policy.json"
}

# Use the cdp cli to determin the 
data "external" "cdpcli" {

  count = var.lookup_cdp_account_ids == true ? 1 : 0

  program = ["bash", "${path.module}/run_cdp_get_cred_prereqs.sh"]
  query = {
    infra_type  = var.infra_type
    cdp_profile = var.cdp_profile
    cdp_region  = var.cdp_control_plane_region
  }
}
