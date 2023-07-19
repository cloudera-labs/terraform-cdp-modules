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

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

}

provider "azuread" {

}

module "ex01_minimal_inputs" {
  source = "../.."

  env_prefix   = var.env_prefix
  azure_region = var.azure_region

  deployment_template = var.deployment_template

  ingress_extra_cidrs_and_ports = var.ingress_extra_cidrs_and_ports

}
