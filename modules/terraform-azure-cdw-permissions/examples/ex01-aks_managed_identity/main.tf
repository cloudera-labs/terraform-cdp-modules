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
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.46.0"
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

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

}

provider "azuread" {
}

module "cdp_azure_prereqs" {
  source = "../../../terraform-cdp-azure-pre-reqs"

  env_prefix   = var.env_prefix
  azure_region = var.azure_region

  deployment_template           = var.deployment_template
  ingress_extra_cidrs_and_ports = var.ingress_extra_cidrs_and_ports

  # Tags to apply resources (omitted by default)
  env_tags = var.env_tags

}

module "cdp_azure_cdw_aks" {
  source = "../.."

  azure_resource_group_name = module.cdp_azure_prereqs.azure_resource_group_name
  azure_region              = var.azure_region

  azure_aks_credential_managed_identity_name = "${var.env_prefix}-aks-credential-identity"
  azure_data_storage_account                 = module.cdp_azure_prereqs.azure_data_storage_account

  tags = var.env_tags

  depends_on = [
    module.cdp_azure_prereqs
  ]
}

output "azure_aks_managed_identity_id" {
  value = module.cdp_azure_cdw_aks.azure_aks_managed_identity_id

  description = "ID of the Azure AKS managed identity"
}