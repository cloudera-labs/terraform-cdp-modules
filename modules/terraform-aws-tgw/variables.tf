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
variable "tgw_name" {
  type        = string
  description = "Name of the Transit Gateway. Also used to prefix associated TGW resource names."

  validation {
    condition     = length(var.tgw_name) <= 128
    error_message = "The length of tgw_name must be 128 characters or less."
  }
}

variable "env_tags" {
  type        = map(any)
  description = "Tags applied to provisioned resources"

  default = null
}

# ------- TGW Settings -------
variable "tgw_dns_support" {
  type = string

  description = "Enable DNS support for the Transit Gateway. Valid values are 'enable' or 'disable'"

  validation {
    condition     = contains(["enable", "disable"], var.tgw_dns_support)
    error_message = "Valid values for var: tgw_dns_support are (enable, disable)."
  }

  default = "enable"
}

variable "tgw_vpn_ecmp_support" {
  type = string

  description = "Enable VPN Equal Cost Multipath Protocol support for the Transit Gateway. Valid values are 'enable' or 'disable'"

  validation {
    condition     = contains(["enable", "disable"], var.tgw_vpn_ecmp_support)
    error_message = "Valid values for var: tgw_vpn_ecmp_support are (enable, disable)."
  }

  default = "enable"
}

variable "tgw_default_route_table_association" {
  type = string

  description = "Automatically associate resource attachments with the default TGW association route table. Valid values are 'enable' or 'disable'"

  validation {
    condition     = contains(["enable", "disable"], var.tgw_default_route_table_association)
    error_message = "Valid values for var: tgw_default_route_table_association are (enable, disable)."
  }

  default = "disable"
}

variable "tgw_default_route_table_propagation" {
  type = string

  description = "Automatically propagate resource attachments with the default TGW propagation route table. Valid values are 'enable' or 'disable'"

  validation {
    condition     = contains(["enable", "disable"], var.tgw_default_route_table_propagation)
    error_message = "Valid values for var: tgw_default_route_table_propagation are (enable, disable)."
  }

  default = "disable"
}

# ------- VPC Attachment settings -------
variable "vpc_attachments" {
  type = any

  description = "Map of map of VPC details to attach to the Transit Gateway. Type any to avoid validation on map key but should at least contain the vpc id and subnet id for the TGW attachment."

  default = {}

  # example:
  #   vpc1 = { # <-- key name to identify vpc attachment
  #     vpc_id =  # <-- the vpc_id
  #     subnet_ids =  # <-- the subnet_ids
  #     create_tgw_route_table # <-- create a separate TGW Route Table for this VPC attachment
  #   },
  #   vpc 2 = {
  #     vpc_id = 
  #     subnet_ids =
  #   }

}

variable "vpc_attach_tgw_default_route_table_association" {
  type = bool

  description = "Default behaviour for the VPC Attachment transit_gateway_default_route_table_association parameter if not specified in var.vpc_attachments"

  default = false

}

variable "vpc_attach_tgw_default_route_table_propagation" {
  type = bool

  description = "Default behaviour for the VPC Attachment transit_gateway_default_route_table_propagation parameter if not specified in var.vpc_attachments"

  default = false

}

variable "vpc_attach_dns_support" {
  type = string

  description = "Default behaviour for the VPC Attachment dns_support parameter if not specified in var.vpc_attachments"

  validation {
    condition     = contains(["enable", "disable"], var.vpc_attach_dns_support)
    error_message = "Valid values for var: vpc_attach_dns_support are (enable, disable)."
  }

  default = "enable"

}