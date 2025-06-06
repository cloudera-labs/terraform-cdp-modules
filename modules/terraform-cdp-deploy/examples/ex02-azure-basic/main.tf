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

  # Inputs for BYO-VNet
  create_vnet            = var.create_vnet
  cdp_resourcegroup_name = var.cdp_resourcegroup_name
  cdp_vnet_name          = var.cdp_vnet_name
  cdp_subnet_names       = var.cdp_subnet_names
  cdp_gw_subnet_names    = var.cdp_gw_subnet_names

  # Tags to apply resources (omitted by default)
  env_tags = var.env_tags

}

module "cdp_deploy" {
  source = "../.."

  env_prefix          = var.env_prefix
  infra_type          = "azure"
  region              = var.azure_region
  public_key_text     = var.public_key_text
  deployment_template = var.deployment_template
  cdp_groups          = var.cdp_groups

  environment_async_creation = var.environment_async_creation
  datalake_async_creation    = var.datalake_async_creation

  compute_cluster_enabled       = var.compute_cluster_enabled
  compute_cluster_configuration = var.compute_cluster_configuration

  # From pre-reqs module output
  azure_subscription_id = module.cdp_azure_prereqs.azure_subscription_id
  azure_tenant_id       = module.cdp_azure_prereqs.azure_tenant_id

  azure_cdp_resource_group_name     = module.cdp_azure_prereqs.azure_cdp_resource_group_name
  azure_network_resource_group_name = module.cdp_azure_prereqs.azure_network_resource_group_name
  azure_vnet_name                   = module.cdp_azure_prereqs.azure_vnet_name
  azure_cdp_subnet_names            = module.cdp_azure_prereqs.azure_cdp_subnet_names
  azure_cdp_gateway_subnet_names    = module.cdp_azure_prereqs.azure_cdp_gateway_subnet_names

  azure_environment_flexible_server_delegated_subnet_names = module.cdp_azure_prereqs.azure_cdp_flexible_server_delegated_subnet_names
  azure_datalake_flexible_server_delegated_subnet_name     = try(module.cdp_azure_prereqs.azure_cdp_flexible_server_delegated_subnet_names[0], null)
  azure_database_private_dns_zone_id                       = module.cdp_azure_prereqs.azure_database_private_dns_zone_id

  azure_security_group_default_uri = module.cdp_azure_prereqs.azure_security_group_default_uri
  azure_security_group_knox_uri    = module.cdp_azure_prereqs.azure_security_group_knox_uri

  data_storage_location   = module.cdp_azure_prereqs.azure_data_storage_location
  log_storage_location    = module.cdp_azure_prereqs.azure_log_storage_location
  backup_storage_location = module.cdp_azure_prereqs.azure_backup_storage_location

  azure_xaccount_app_uuid  = module.cdp_azure_prereqs.azure_xaccount_app_uuid
  azure_xaccount_app_pword = module.cdp_azure_prereqs.azure_xaccount_app_pword

  azure_idbroker_identity_id      = module.cdp_azure_prereqs.azure_idbroker_identity_id
  azure_datalakeadmin_identity_id = module.cdp_azure_prereqs.azure_datalakeadmin_identity_id
  azure_ranger_audit_identity_id  = module.cdp_azure_prereqs.azure_ranger_audit_identity_id
  azure_log_identity_id           = module.cdp_azure_prereqs.azure_log_identity_id
  azure_raz_identity_id           = module.cdp_azure_prereqs.azure_raz_identity_id

  # Tags to apply resources (omitted by default)
  env_tags = var.env_tags

  depends_on = [
    module.cdp_azure_prereqs
  ]
}
