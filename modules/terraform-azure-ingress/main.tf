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

# Default SG
resource "azurerm_network_security_group" "cdp_default_sg" {

  count = local.create_default_security_group ? 1 : 0

  name                = var.default_security_group_name
  location            = var.azure_region
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, { Name = var.default_security_group_name })

}

# Create security group rules for extra list of ingress rules
resource "azurerm_network_security_rule" "cdp_default_sg_ingress_extra_access" {

  count = local.create_default_security_group ? 1 : 0

  name                        = "AllowAccessForExtraCidrsAndPorts"
  priority                    = var.default_security_group_ingress_priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = var.default_security_group_ingress_protocol
  source_address_prefixes     = var.ingress_extra_cidrs_and_ports.cidrs
  destination_address_prefix  = var.default_security_group_ingress_destination_address_prefix
  source_port_range           = "*"
  destination_port_ranges     = var.ingress_extra_cidrs_and_ports.ports
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.cdp_default_sg[0].name
}

# Knox SG
resource "azurerm_network_security_group" "cdp_knox_sg" {

  count = local.create_knox_security_group ? 1 : 0

  name                = var.knox_security_group_name
  location            = var.azure_region
  resource_group_name = var.resource_group_name

  tags = merge(var.tags, { Name = var.knox_security_group_name })

}

# Create security group rules for extra list of ingress rules
resource "azurerm_network_security_rule" "cdp_knox_sg_ingress_extra_access" {

  count = local.create_knox_security_group ? 1 : 0

  name                        = "AllowAccessForExtraCidrsAndPorts"
  priority                    = var.knox_security_group_ingress_priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = var.knox_security_group_ingress_protocol
  source_address_prefixes     = var.ingress_extra_cidrs_and_ports.cidrs
  destination_address_prefix  = var.knox_security_group_ingress_destination_address_prefix
  source_port_range           = "*"
  destination_port_ranges     = var.ingress_extra_cidrs_and_ports.ports
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.cdp_knox_sg[0].name
}