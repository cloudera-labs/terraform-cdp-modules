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

module "ex01_existing_role" {
  source = "../.."

  existing_xaccount_role_name = var.existing_xaccount_role_name

}

# ------- Outputs -------
output "xaccount_role_arn" {
  value = module.ex01_existing_role.aws_xaccount_role_arn

  description = "The ARN of the created Cross Account Role"
}
output "xaccount_role_name" {
  value = module.ex01_existing_role.aws_xaccount_role_name

  description = "The name of the created Cross Account Role"
}