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

variable "create_vpc" {
  type = bool

  description = "Flag to specify if the VPC should be created. Otherwise data sources will be used to lookup details of existing resources."

  default = true
}

variable "vpc_name" {
  type = string

  description = "Name of the VPC."

}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"

}

variable "cdp_vpc" {
  type        = bool
  description = "Flag to indicate if the VPC is for a CDP environment"

  default = true
}

variable "private_cidr_range" {
  type        = number
  description = "Size of each private subnet"
}

variable "public_cidr_range" {
  type        = number
  description = "Size of each public subnet"
}

variable "tags" {
  type        = map(any)
  description = "Tags applied to VPC resources"

  default = null
}

variable "private_subnet_tags" {
  type        = map(any)
  description = "Extra tags to apply to Private Subnets"

  default = null
}

variable "public_subnet_tags" {
  type        = map(any)
  description = "Extra tags to apply to Private Subnets"

  default = null
}

variable "deployment_template" {
  type = string

  description = "Deployment Pattern to use for Cloud resources and CDP"

  validation {
    condition     = var.deployment_template == null ? true : contains(["public", "semi-private", "private"], var.deployment_template)
    error_message = "Valid values for var: deployment_template are (public, semi-private, private)."
  }

  default = null
}

variable "private_network_extensions" {
  type = bool

  description = "Enable creation of resources for connectivity to CDP Control Plane (public subnet and NAT Gateway) for Private Deployment. Only relevant for private deployment template."

  default = null
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT Gateway for VPC"

  default = null
}

variable "single_nat_gateway" {
  type        = bool
  description = "Use a single NAT Gateway for the VPC"

  default = null
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support for the VPC"

  default = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS Hostname support for the VPC"

  default = true
}

variable "vpc_public_subnets_map_public_ip_on_launch" {
  description = "Auto-assign public IP on launch for instances created in Public Subnets.  Exposes default value of VPC module variable to allow for overriding. Only used when create_vpc is true."
  type        = bool

  default = true
}


variable "vpc_public_inbound_acl_rules" {
  description = "Inbound network ACLs for Public subnets. Exposes default value of VPC module variable to allow for overriding. Only used when create_vpc is true."
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "vpc_public_outbound_acl_rules" {
  description = "Public subnets outbound network ACLs. Exposes default value of VPC module variable to allow for overriding. Only used when create_vpc is true."
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "vpc_private_inbound_acl_rules" {
  description = "Private subnets inbound network ACLs. Exposes default value of VPC module variable to allow for overriding. Only used when create_vpc is true."
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "vpc_private_outbound_acl_rules" {
  description = "Private subnets outbound network ACLs. Exposes default value of VPC module variable to allow for overriding. Only used when create_vpc is true."
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

# VPC and Subnet IDs for existing resources (used when create_vpc = false)
variable "existing_vpc_id" {
  type        = string
  description = "ID of existing VPC. Required if create_vpc is false."

  default = null
}

variable "existing_public_subnet_ids" {
  type        = list(any)
  description = "List of existing public subnet ids. Required if create_vpc is false."

  default = null
}

variable "existing_private_subnet_ids" {
  type        = list(any)
  description = "List of existing private subnet ids. Required if create_vpc is false."

  default = null
}
