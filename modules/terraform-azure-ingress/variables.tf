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
variable "azure_region" {
  type        = string
  description = "Region which Cloud resources will be created"

}

variable "tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

  default = null
}


# ------- Azure specific settings -------
variable "resource_group_name" {
  type        = string
  description = "Azrue Resource Group for Managed Identities."

}

# Security Groups
variable "default_security_group_name" {
  type = string

  description = "Default Security Group for Cloudera on cloud environment"

  default = null

  validation {
    condition     = (var.default_security_group_name == null ? true : length(var.default_security_group_name) >= 1 && length(var.default_security_group_name) <= 80)
    error_message = "The length of default_security_group_name must be 80 characters or less."
  }

  validation {
    condition     = (var.default_security_group_name == null ? true : can(regex("^[a-zA-Z0-9\\-\\_\\.]{1,80}$", var.default_security_group_name)))
    error_message = "default_security_group_name can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
  }
}

variable "knox_security_group_name" {
  type = string

  description = "Knox Security Group for CCloudera on cloud environment"

  default = null

  validation {
    condition     = (var.knox_security_group_name == null ? true : length(var.knox_security_group_name) >= 1 && length(var.knox_security_group_name) <= 80)
    error_message = "The length of knox_security_group_name must be 80 characters or less."
  }

  validation {
    condition     = (var.knox_security_group_name == null ? true : can(regex("^[a-zA-Z0-9\\-\\_\\.]{1,80}$", var.knox_security_group_name)))
    error_message = "knox_security_group_name can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
  }
}

variable "ingress_extra_cidrs_and_ports" {
  type = object({
    cidrs = list(string)
    ports = list(number)
  })
  description = "List of extra CIDR blocks and ports to include in Security Group Ingress rules"

  default = {
    cidrs = [],
    ports = []
  }
}

variable "default_security_group_ingress_protocol" {
  type        = string
  description = "Protocol for Default Security Group Ingress rules"

  default = "Tcp"
}

variable "default_security_group_ingress_priority" {
  type        = number
  description = "Priority for Default Security Group Ingress rules"

  default = 201
}

variable "default_security_group_ingress_destination_address_prefix" {
  type        = string
  description = "Destination address prefix for Default Security Group Ingress rules"

  default = "*"
}

variable "knox_security_group_ingress_protocol" {
  type        = string
  description = "Protocol for Knox Security Group Ingress rules"

  default = "Tcp"
}

variable "knox_security_group_ingress_priority" {
  type        = number
  description = "Priority for Knox Security Group Ingress rules"

  default = 201
}

variable "knox_security_group_ingress_destination_address_prefix" {
  type        = string
  description = "Destination address prefix for Knox Security Group Ingress rules"

  default = "*"
}

# ------- Support for existing Security Groups -------
variable "existing_default_security_group_name" {
  type        = string
  description = "Name of existing Default Security Group for Cloudera on cloud environment. If set then no security group or ingress rules are created for the Default SG."

  default = null
}

variable "existing_knox_security_group_name" {
  type        = string
  description = "Name of existing Knox Security Group for Cloudera on cloud environment. If set then no security group or ingress rules are created for the Knox SG."

  default = null
}
