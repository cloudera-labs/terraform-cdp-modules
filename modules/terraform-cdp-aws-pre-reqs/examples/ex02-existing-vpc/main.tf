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

provider "aws" {
  region = var.aws_region
}

module "ex02_existing_vpc" {
  source = "../.."

  env_prefix = var.env_prefix
  aws_region = var.aws_region

  deployment_template = var.deployment_template

  ingress_extra_cidrs_and_ports = var.ingress_extra_cidrs_and_ports

  # Using CDP TF Provider cred pre-reqs data source for values of xaccount account_id and external_id
  xaccount_account_id         = data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.account_id
  xaccount_external_id        = data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.external_id
  xaccount_account_policy_doc = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policy)

  # Policy documents from CDP TF Provider cred pre-reqs
  idbroker_policy_doc = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Idbroker_Assumer"])

  data_bucket_access_policy_doc   = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Bucket_Access"])
  log_bucket_access_policy_doc    = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Bucket_Access"])
  backup_bucket_access_policy_doc = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Bucket_Access"])

  datalake_admin_s3_policy_doc = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Datalake_Admin"])
  datalake_backup_policy_doc   = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Datalake_Backup"])
  datalake_restore_policy_doc  = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Datalake_Restore"])

  log_data_access_policy_doc = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Log_Policy"])
  ranger_audit_s3_policy_doc = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policies["Ranger_Audit"])

  create_vpc             = var.create_vpc
  cdp_vpc_id             = aws_vpc.cdp_vpc.id
  cdp_public_subnet_ids  = values(aws_subnet.cdp_public_subnets)[*].id
  cdp_private_subnet_ids = values(aws_subnet.cdp_private_subnets)[*].id

  # Explicit dependency on resources in vpc.tf
  depends_on = [
    aws_internet_gateway.cdp_igw,
    aws_default_route_table.cdp_public_route_table,
    aws_nat_gateway.cdp_nat_gateway,
    aws_route_table.cdp_private_route_table
  ]

}

# Use the CDP Terraform Provider to find the xaccount account and external ids
terraform {
  required_providers {
    cdp = {
      source  = "cloudera/cdp"
      version = "0.6.1"
    }
  }
}

data "cdp_environments_aws_credential_prerequisites" "cdp_prereqs" {}
