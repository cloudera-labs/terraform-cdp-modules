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

terraform {
  required_version = ">= 1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
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

# ------- Azure Resource Group -------
module "rmgp" {
  source = "../../../terraform-azure-resource-group"

  resourcegroup_name = "${var.env_prefix}-rg"
  azure_region       = var.azure_region

  tags = merge(var.env_tags, { Name = "${var.env_prefix}-rg" })
}

# ------- Azure VNet and SGs -------
module "ex01_cdp_vnet" {
  source = "../.."

  deployment_template = var.deployment_template
  resourcegroup_name  = module.rmgp.resource_group_name
  vnet_name           = "${var.env_prefix}-net"
  vnet_cidr           = var.vnet_cidr
  vnet_region         = var.azure_region

  cdp_subnet_prefix       = "${var.env_prefix}-cdp-sbnt"
  gateway_subnet_prefix   = "${var.env_prefix}-gw-sbnt"
  delegated_subnet_prefix = "${var.env_prefix}-delegated-sbnt"

  subnet_count                                  = var.subnet_count
  cdp_subnet_range                              = var.cdp_subnet_range
  cdp_subnets_private_endpoint_network_policies = var.cdp_subnets_private_endpoint_network_policies

  gateway_subnet_range                              = var.gateway_subnet_range
  gateway_subnets_private_endpoint_network_policies = var.gateway_subnets_private_endpoint_network_policies
  delegated_subnet_range                            = var.delegated_subnet_range

  tags = var.env_tags

  depends_on = [module.rmgp]
}
