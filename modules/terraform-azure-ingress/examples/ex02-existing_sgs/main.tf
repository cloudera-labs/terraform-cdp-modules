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

# Create security groups to pass in to module as pre-existing SGs
resource "azurerm_network_security_group" "cdp_default_sg" {
  name                = "${var.env_prefix}-existing-default-sg"
  location            = var.azure_region
  resource_group_name = module.rmgp.resource_group_name

  tags = merge(var.env_tags, { Name = "${var.env_prefix}-existing-default-sg" })

}

resource "azurerm_network_security_group" "cdp_knox_sg" {
  name                = "${var.env_prefix}-existing-knox-sg"
  location            = var.azure_region
  resource_group_name = module.rmgp.resource_group_name

  tags = merge(var.env_tags, { Name = "${var.env_prefix}-existing-knox-sg" })

}

# ------- Azure SGs -------
module "ex02_sg" {
  source = "../.."

  resource_group_name = module.rmgp.resource_group_name
  azure_region        = var.azure_region

  existing_default_security_group_name = azurerm_network_security_group.cdp_default_sg.name
  existing_knox_security_group_name    = azurerm_network_security_group.cdp_knox_sg.name

  # default_security_group_name = "${var.env_prefix}-default-sg"
  # knox_security_group_name    = "${var.env_prefix}-knox-sg"

  # ingress_extra_cidrs_and_ports = var.ingress_extra_cidrs_and_ports

  # tags = var.env_tags

  depends_on = [module.rmgp]
}
