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

  description = "Name of the VPC."

}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"

}

variable "tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

}

variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in resource descriptions"
}

variable "deployment_template" {
  type = string

  description = "Deployment Pattern to use for Cloud resources and CDP"

  validation {
    condition     = contains(["public", "semi-private", "private"], var.deployment_template)
    error_message = "Valid values for var: deployment_template are (public, semi-private, private)."
  }
}

variable "private_network_extensions" {
  type = bool

  description = "Enable creation of resources for connectivity to CDP Control Plane (public subnet and NAT Gateway) for Private Deployment. Only relevant for private deployment template."

}

variable "vpc_public_subnets_map_public_ip_on_launch" {
  description = "Auto-assign public IP on launch for instances created in Public Subnets.  Exposes default value of VPC module variable to allow for overriding. Only used when create_vpc is true."
  type        = bool

}

variable "vpc_public_inbound_acl_rules" {
  description = "Inbound network ACLs for Public subnets. Exposes default value of VPC module variable to allow for overriding."
  type        = list(map(string))

}

variable "vpc_public_outbound_acl_rules" {
  description = "Public subnets outbound network ACLs. Exposes default value of VPC module variable to allow for overriding."
  type        = list(map(string))

}

variable "vpc_private_inbound_acl_rules" {
  description = "Private subnets inbound network ACLs. Exposes default value of VPC module variable to allow for overriding."
  type        = list(map(string))

}

variable "vpc_private_outbound_acl_rules" {
  description = "Private subnets outbound network ACLs.  Exposes default value of VPC module variable to allow for overriding."
  type        = list(map(string))

}