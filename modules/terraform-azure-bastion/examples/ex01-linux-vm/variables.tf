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

# ------- Global settings -------
variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in resource descriptions"
}

variable "azure_region" {
  type        = string
  description = "Region which Cloud resources will be created"
}

variable "env_tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

  default = null
}

# ------- Network Resources -------
variable "vnet_cidr" {
  type        = string
  description = "VPC CIDR Block. Required if create_vnet is true."

  default = "10.10.0.0/16"
}

variable "subnet_count" {
  type        = string
  description = "Number of CDP Subnets Required"

  default = "3"
}

variable "cdp_subnet_range" {
  type        = number
  description = "Size of each (internal) cluster subnet. Required if create_vnet is true."

  default = 19
}

variable "cdp_subnets_private_endpoint_network_policies" {
  type = string

  description = "Enable or Disable network policies for the private endpoint on the CDP subnets"

  validation {
    condition     = (var.cdp_subnets_private_endpoint_network_policies == null ? true : contains(["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.cdp_subnets_private_endpoint_network_policies))
    error_message = "Valid values for var: cdp_subnets_private_endpoint_network_policies are (Disabled, Enabled, NetworkSecurityGroupEnabled, RouteTableEnabled)."
  }

  default = "Enabled"
}

variable "gateway_subnet_range" {
  type        = number
  description = "Size of each gateway subnet. Required if create_vnet is true."

  default = 24
}

variable "gateway_subnets_private_endpoint_network_policies" {
  type = string

  description = "Enable or Disable network policies for the private endpoint on the Gateway subnets"

  validation {
    condition     = (var.gateway_subnets_private_endpoint_network_policies == null ? true : contains(["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.gateway_subnets_private_endpoint_network_policies))
    error_message = "Valid values for var: gateway_subnets_private_endpoint_network_policies are (Disabled, Enabled, NetworkSecurityGroupEnabled, RouteTableEnabled)."
  }

  default = "Enabled"
}

variable "delegated_subnet_range" {
  type        = number
  description = "Size of each Postgres Flexible Server delegated subnet. Required if create_vnet is true."

  default = 26
}

# ------- Bastion settings -------
variable "ingress_extra_cidrs" {
  type        = list(string)
  description = "List of extra ingress rules to create."

  default = []
}

variable "ingress_extra_cidr" {
  type        = string
  description = "Extra ingress rule to create."

  default = ""
}

variable "public_key_text_input" {
  type        = string
  description = "The SSH public key for accessing the Linux bastion."

  default = null
}