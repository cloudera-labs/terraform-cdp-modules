# Copyright 2025 Cloudera, Inc. All Rights Reserved.
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
  required_version = ">= 1.9.0"
  required_providers {
    cdp = {
      source  = "cloudera/cdp"
      version = ">= 0.6.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.30"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.5"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.1"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.2.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "cdp_aws_prereqs" {
  source = "../../../terraform-cdp-aws-pre-reqs"

  env_prefix = var.env_prefix
  aws_region = var.aws_region

  deployment_template           = var.deployment_template
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

  # Inputs for BYO-VPC
  create_vpc             = var.create_vpc
  cdp_vpc_id             = var.cdp_vpc_id
  cdp_public_subnet_ids  = var.cdp_public_subnet_ids
  cdp_private_subnet_ids = var.cdp_private_subnet_ids

  # Inputs for Control Plane Connectivity in fully private 
  private_network_extensions = var.private_network_extensions

  # Tags to apply resources (omitted by default)
  env_tags = var.env_tags

}

module "cdp_deploy" {
  source = "../.."

  env_prefix          = var.env_prefix
  infra_type          = "aws"
  region              = var.aws_region
  keypair_name        = var.aws_key_pair
  deployment_template = var.deployment_template
  cdp_groups          = var.cdp_groups

  environment_async_creation = var.environment_async_creation
  datalake_async_creation    = var.datalake_async_creation

  # From pre-reqs module output
  aws_vpc_id             = module.cdp_aws_prereqs.aws_vpc_id
  aws_public_subnet_ids  = module.cdp_aws_prereqs.aws_public_subnet_ids
  aws_private_subnet_ids = module.cdp_aws_prereqs.aws_private_subnet_ids

  aws_security_group_default_id = module.cdp_aws_prereqs.aws_security_group_default_id
  aws_security_group_knox_id    = module.cdp_aws_prereqs.aws_security_group_knox_id

  data_storage_location   = module.cdp_aws_prereqs.aws_data_storage_location
  log_storage_location    = module.cdp_aws_prereqs.aws_log_storage_location
  backup_storage_location = module.cdp_aws_prereqs.aws_backup_storage_location

  aws_xaccount_role_arn       = module.cdp_aws_prereqs.aws_xaccount_role_arn
  aws_datalake_admin_role_arn = module.cdp_aws_prereqs.aws_datalake_admin_role_arn
  aws_ranger_audit_role_arn   = module.cdp_aws_prereqs.aws_ranger_audit_role_arn
  aws_raz_role_arn            = module.cdp_aws_prereqs.aws_datalake_admin_role_arn

  aws_log_instance_profile_arn      = module.cdp_aws_prereqs.aws_log_instance_profile_arn
  aws_idbroker_instance_profile_arn = module.cdp_aws_prereqs.aws_idbroker_instance_profile_arn

  # Tags to apply resources (omitted by default)
  env_tags = var.env_tags

  depends_on = [
    module.cdp_aws_prereqs
  ]
}

# Use the CDP Terraform Provider to find the xaccount account and external ids
data "cdp_environments_aws_credential_prerequisites" "cdp_prereqs" {}
