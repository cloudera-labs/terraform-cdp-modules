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

# ------- Creating "existing" VNet -------
module "ex02_existing_vnet" {
  source = "../../../terraform-azure-vnet"

  deployment_template = "public"
  resourcegroup_name  = module.rmgp.resource_group_name
  vnet_name           = "${var.env_prefix}-existing-net"
  vnet_cidr           = var.vnet_cidr
  vnet_region         = var.azure_region

  cdp_subnet_prefix       = "${var.env_prefix}-existing-cdp-sbnt"
  gateway_subnet_prefix   = "${var.env_prefix}-existing-gw-sbnt"
  delegated_subnet_prefix = "${var.env_prefix}-existing-delegated-sbnt"

  subnet_count                                  = var.subnet_count
  cdp_subnet_range                              = var.cdp_subnet_range
  cdp_subnets_private_endpoint_network_policies = var.cdp_subnets_private_endpoint_network_policies

  gateway_subnet_range                              = var.gateway_subnet_range
  gateway_subnets_private_endpoint_network_policies = var.gateway_subnets_private_endpoint_network_policies
  delegated_subnet_range                            = var.delegated_subnet_range

  tags = var.env_tags

  depends_on = [module.rmgp]
}

# ------- Create SSH Keypair if input public_key_text or bastion_admin_password is not specified
# Create and save a RSA key
resource "tls_private_key" "cdp_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save the private key to ./<env_prefix>-ssh-key.pem
resource "local_sensitive_file" "pem_file" {
  filename             = "${var.env_prefix}-ssh-key.pem"
  file_permission      = "600"
  directory_permission = "700"
  content              = tls_private_key.cdp_private_key.private_key_pem
}

# ------- Azure Bastion Host -------
module "ex01_bastion" {
  source = "../.."

  bastion_region             = var.azure_region
  bastion_resourcegroup_name = module.rmgp.resource_group_name
  bastion_subnet_id          = module.ex02_existing_vnet.vnet_cdp_subnet_ids[0]

  bastion_user_data           = base64encode(file("./files/ex-bash.sh"))
  replace_on_user_data_change = true
  bastion_public_ip_static    = true

  bastion_admin_username = var.env_prefix

  public_key_text = var.public_key_text_input != null ? var.public_key_text_input : tls_private_key.cdp_private_key.public_key_openssh
  # bastion_admin_password = "Test#123"
  # disable_pwd_auth = false

  bastion_host_name           = "${var.env_prefix}-bastion"
  bastion_security_group_name = "${var.env_prefix}-sg"
  bastion_public_ip_name      = "${var.env_prefix}-pip"
  bastion_nic_name            = "${var.env_prefix}-nic"
  bastion_ipconfig_name       = "${var.env_prefix}-ipconfig"

  ingress_rules = [
    {
      rule_name          = "vnet"
      priority           = 101
      protocol           = "Tcp"
      src_port_range     = "*"
      dest_port_range    = "*"
      src_addr_prefixes  = module.ex02_existing_vnet.vnet_address_space
      dest_addr_prefixes = module.ex02_existing_vnet.vnet_address_space
    },
    {
      rule_name        = "ssh"
      priority         = 100
      protocol         = "Tcp"
      src_port_range   = "*"
      dest_port_range  = "22"
      src_addr_prefix  = var.ingress_extra_cidr
      dest_addr_prefix = var.ingress_extra_cidr
    }
  ]

  tags = var.env_tags

  depends_on = [module.ex02_existing_vnet]
}
