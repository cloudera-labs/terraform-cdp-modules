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

# ------- Global settings -------
variable "aws_profile" {
  type        = string
  description = "Profile for AWS cloud credentials"

  # Profile is default unless explicitly specified
  default = "default"
}

variable "aws_region" {
  type        = string
  description = "Region which Cloud resources will be created"
}

variable "env_tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

  default = null
}

# ------- Network Resources -------
variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block. Required if create_vpc is true."

}

variable "vpc_name" {
  type = string

  description = "Name of the VPC. Defaults to <env_prefix>-net if not specified"

}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT Gateway for VPC"

}

variable "private_cidr_range" {
  type        = number
  description = "Size of each private subnet. Required if create_vpc is true. Number of subnets will be automatically selected to match on the number of Availability Zones in the selected AWS region. (Depending on the selected deployment pattern, one subnet will be created per region.)"

  default = 19
}

variable "public_cidr_range" {
  type        = number
  description = "Size of each public subnet. Required if create_vpc is true. Number of subnets will be automatically selected to match on the number of Availability Zones in the selected AWS region. (Depending on the selected deployment pattern, one subnet will be created per region.)"

  default = 24
}

variable "private_network_extensions" {
  type = bool

  description = "Enable creation of resources for connectivity to CDP Control Plane (public subnet and NAT Gateway) for Private Deployment. Only relevant for private deployment template"

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
