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


# ------- VNet -------
resource "azurerm_virtual_network" "cdp_vnet" {

  count = var.create_vnet ? 1 : 0

  name                = var.vnet_name
  location            = var.vnet_region
  resource_group_name = var.resourcegroup_name
  address_space       = [var.vnet_cidr]
  dns_servers         = []

  tags = merge(var.tags, { Name = var.vnet_name })
}

# ------- Subnets -------
# Azure VNet Public Subnets
resource "azurerm_subnet" "cdp_subnets" {

  for_each = { for idx, subnet in local.cdp_subnets : idx => subnet
  if var.create_vnet }

  virtual_network_name = azurerm_virtual_network.cdp_vnet[0].name
  resource_group_name  = var.resourcegroup_name
  name                 = each.value.name
  address_prefixes     = [each.value.cidr]

  service_endpoints                 = ["Microsoft.Sql", "Microsoft.Storage"]
  private_endpoint_network_policies = var.cdp_subnets_private_endpoint_network_policies
  default_outbound_access_enabled   = var.cdp_subnets_default_outbound_access_enabled
}

resource "azurerm_subnet" "gateway_subnets" {

  for_each = { for idx, subnet in local.gw_subnets : idx => subnet
  if var.create_vnet }

  virtual_network_name = azurerm_virtual_network.cdp_vnet[0].name
  resource_group_name  = var.resourcegroup_name
  name                 = each.value.name
  address_prefixes     = [each.value.cidr]

  service_endpoints                 = ["Microsoft.Sql", "Microsoft.Storage"]
  private_endpoint_network_policies = var.gateway_subnets_private_endpoint_network_policies
  default_outbound_access_enabled   = var.gateway_subnets_default_outbound_access_enabled
}

resource "azurerm_subnet" "delegated_subnet" {

  for_each = { for idx, subnet in local.delegated_subnets : idx => subnet
  if var.create_vnet }

  virtual_network_name = azurerm_virtual_network.cdp_vnet[0].name
  resource_group_name  = var.resourcegroup_name
  name                 = each.value.name
  address_prefixes     = [each.value.cidr]

  service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]

  delegation {
    name = "flexserver-delegation"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# ------- NAT Gateway -------
# Public IP address for NAT gateway
resource "azurerm_public_ip" "cdp_nat_public_ip" {
  count = var.create_vnet && var.create_nat_gateway ? 1 : 0

  name                = var.nat_public_ip_name
  location            = var.vnet_region
  resource_group_name = var.resourcegroup_name
  allocation_method   = var.nat_public_ip_allocation_method
  sku                 = var.nat_public_ip_sku
}

# NAT Gateway
resource "azurerm_nat_gateway" "cdp_nat_gateway" {
  count = var.create_vnet && var.create_nat_gateway ? 1 : 0

  name                = var.nat_gateway_name
  location            = var.vnet_region
  resource_group_name = var.resourcegroup_name
}

# Associate NAT Gateway with Public IP
resource "azurerm_nat_gateway_public_ip_association" "cdp_nat_ip_association" {
  count = var.create_vnet && var.create_nat_gateway ? 1 : 0

  nat_gateway_id       = azurerm_nat_gateway.cdp_nat_gateway[0].id
  public_ip_address_id = azurerm_public_ip.cdp_nat_public_ip[0].id
}

# Associate NAT Gateway with CDP Subnets
resource "azurerm_subnet_nat_gateway_association" "nat_cdp_subnet_association" {

  for_each = var.create_vnet && var.create_nat_gateway ? azurerm_subnet.cdp_subnets : {}

  subnet_id      = each.value.id
  nat_gateway_id = azurerm_nat_gateway.cdp_nat_gateway[0].id
}

# Associate NAT Gateway with gateway Subnets
resource "azurerm_subnet_nat_gateway_association" "nat_gateway_subnet_association" {

  for_each = var.create_vnet && var.create_nat_gateway ? azurerm_subnet.gateway_subnets : {}

  subnet_id      = each.value.id
  nat_gateway_id = azurerm_nat_gateway.cdp_nat_gateway[0].id
}

