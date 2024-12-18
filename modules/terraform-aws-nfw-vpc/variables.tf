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

variable "vpc_name" {
  type = string

  description = "Name of the VPC"

  validation {
    condition     = length(var.vpc_name) <= 64
    error_message = "The length of vpc_name must be 64 characters or less."
  }
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block. Only used when create_vpc is true."

}

variable "subnet_name_prefix" {
  type = string

  description = "Prefix string for the name of all Subnets created"

}

variable "route_table_name_prefix" {
  type = string

  description = "Prefix string for the name of all Route Tables created"

}

variable "nat_gateway_name_prefix" {
  type = string

  description = "Prefix string for the name of all NAT Gateway resources"

}

variable "tgw_cidr_range" {
  type        = number
  description = "Size of each Transit Gateway subnets."

  default = 24
}

variable "fw_cidr_range" {
  type        = number
  description = "Size of each Firewall subnets."

  default = 24
}

variable "nat_cidr_range" {
  type        = number
  description = "Size of each NAT subnets."

  default = 24
}

variable "tags" {
  type        = map(any)
  description = "Tags applied to VPC resources."

  default = null
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support for the VPC. Only used when create_vpc is true."

  default = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS Hostname support for the VPC. Only used when create_vpc is true."

  default = true
}



