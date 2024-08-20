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
      version = "~> 0.6.1"
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

  # Using CDP TF Provider cred pre-reqs data source for values of xaccount account_id and external_id
  xaccount_account_id  = data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.account_id
  xaccount_external_id = data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.external_id

  xaccount_policy_name        = "${var.env_prefix}-xaccount-policy"
  xaccount_account_policy_doc = base64decode(data.cdp_environments_aws_credential_prerequisites.cdp_prereqs.policy)

  xaccount_role_name = "${var.env_prefix}-xaccount-role"

}

# Use the CDP Terraform Provider to find the xaccount account and external ids
data "cdp_environments_aws_credential_prerequisites" "cdp_prereqs" {}

# ------- Outputs -------
output "xaccount_role_arn" {
  value = module.ex01_minimal_inputs.aws_xaccount_role_arn

  description = "The ARN of the created Cross Account Role"
}
output "xaccount_role_name" {
  value = module.ex01_minimal_inputs.aws_xaccount_role_name

  description = "The name of the created Cross Account Role"
}