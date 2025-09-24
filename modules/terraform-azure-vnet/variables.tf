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

variable "create_vnet" {
  type = bool

  description = "Flag to specify if the VNet should be created. Otherwise data sources will be used to lookup details of existing resources."

  default = true
}

variable "deployment_template" {
  type = string

  description = "Deployment Pattern to use for Cloud resources and CDP"

  validation {
    condition     = contains(["public", "semi-private", "private"], var.deployment_template)
    error_message = "Valid values for var: deployment_template are (public, semi-private, private)."
  }
}

variable "resourcegroup_name" {
  type        = string
  description = "Resource Group Name"
}

variable "vnet_name" {
  type        = string
  description = "VNet name"

  validation {
    condition     = (var.vnet_name == null ? true : length(var.vnet_name) >= 1 && length(var.vnet_name) <= 80)
    error_message = "The length of vnet_name must be 80 characters or less."
  }

  validation {
    condition     = (var.vnet_name == null ? true : can(regex("^[a-zA-Z0-9\\-\\_\\.]{1,80}$", var.vnet_name)))
    error_message = "vnet_name can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
  }

  default = null
}

variable "cdp_subnet_prefix" {
  type        = string
  description = "Prefix string to give each subnet used for CDP resources"

  default = null
}

variable "gateway_subnet_prefix" {
  type        = string
  description = "Prefix string to give each Gateway subnet"

  default = null
}

variable "delegated_subnet_prefix" {
  type        = string
  description = "Prefix string to give each Delegated subnet"

  default = null
}

variable "vnet_cidr" {
  type        = string
  description = "VNet CIDR Block"

  default = null
}

variable "cdp_subnet_range" {
  type        = number
  description = "Size of each (internal) cluster subnet"

  default = null
}

variable "gateway_subnet_range" {
  type        = number
  description = "Size of each gateway subnet"

  default = null
}

variable "delegated_subnet_range" {
  type        = number
  description = "Size of each Postgres Flexible Server delegated subnet"

  default = null
}

variable "vnet_region" {
  type        = string
  description = "Region which VNet will be created"

  default = null
}

variable "subnet_count" {
  type        = string
  description = "Number of Subnets Required"

  default = null
}

variable "tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

  default = null
}

variable "create_delegated_subnet" {
  type = bool

  description = "Flag to specify if the delegated subnet should be created. Only applicable if create_vnet is true."

  default = false
}

variable "create_nat_gateway" {
  type = bool

  description = "Flag to specify if the NAT Gateway should be created. Only applicable if create_vnet is true."

  default = true
}

variable "nat_public_ip_name" {
  type        = string
  description = "Name of the NAT Public IP"

  validation {
    condition     = !(var.create_vnet && var.create_nat_gateway) || var.nat_public_ip_name != null
    error_message = "nat_public_ip_name must not be null when both create_vnet and create_nat_gateway are true."
  }

  default = null
}

variable "nat_gateway_name" {
  type        = string
  description = "Name of the NAT Gateway"

  validation {
    condition     = !(var.create_vnet && var.create_nat_gateway) || var.nat_gateway_name != null
    error_message = "nat_gateway_name must not be null when both create_vnet and create_nat_gateway are true."
  }

  default = null
}

variable "nat_public_ip_allocation_method" {
  type        = string
  description = "Allocation method for the NAT Public IP"

  default = "Static"
}

variable "nat_public_ip_sku" {
  type        = string
  description = "SKU for the NAT Public IP"

  default = "Standard"
}

variable "cdp_subnets_private_endpoint_network_policies" {
  type = string

  description = "Enable or Disable network policies for the private endpoint on the CDP subnets"

  validation {
    condition     = (var.cdp_subnets_private_endpoint_network_policies == null ? true : contains(["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.cdp_subnets_private_endpoint_network_policies))
    error_message = "Valid values for var: cdp_subnets_private_endpoint_network_policies are (Disabled, Enabled, NetworkSecurityGroupEnabled, RouteTableEnabled)."
  }

  default = null
}

variable "gateway_subnets_private_endpoint_network_policies" {
  type = string

  description = "Enable or Disable network policies for the private endpoint on the Gateway subnets"

  validation {
    condition     = (var.gateway_subnets_private_endpoint_network_policies == null ? true : contains(["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.gateway_subnets_private_endpoint_network_policies))
    error_message = "Valid values for var: gateway_subnets_private_endpoint_network_policies are (Disabled, Enabled, NetworkSecurityGroupEnabled, RouteTableEnabled)."
  }

  default = null
}

variable "cdp_subnets_default_outbound_access_enabled" {
  type        = bool
  description = "Enable or Disable default outbound access for the CDP subnets"
  default     = false
}

variable "gateway_subnets_default_outbound_access_enabled" {
  type        = bool
  description = "Enable or Disable default outbound access for the Gateway subnets"
  default     = false
}

# VNet and Subnet IDs for existing resources (used when create_vnet = false)
variable "existing_vnet_name" {
  type        = string
  description = "Name of existing VNet. Required if create_vnet is false."

  default = null
}

variable "existing_cdp_subnet_names" {
  type        = list(any)
  description = "List of existing subnet names for CDP Resources. Required if create_vnet is false."

  default = null
}

variable "existing_gateway_subnet_names" {
  type        = list(any)
  description = "List of existing subnet names for CDP Gateway. Required if create_vnet is false."

  default = null
}

variable "existing_delegated_subnet_names" {
  type        = list(any)
  description = "List of existing subnet names delegated for Flexible Servers. Required if create_vnet is false."

  default = null
}
