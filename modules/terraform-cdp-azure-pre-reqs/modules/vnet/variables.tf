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

}

variable "vnet_cidr" {
  type        = string
  description = "VNet CIDR Block"

}

variable "cdp_subnet_range" {
  type        = number
  description = "Size of each (internal) cluster subnet"

  default = 19
}

variable "gateway_subnet_range" {
  type        = number
  description = "Size of each gateway subnet"

  default = 24  
}

variable "vnet_region" {
  type        = string
  description = "Region which VNet will be created"

}

variable "subnet_count" {
  type        = string
  description = "Number of Subnets Required"

}

variable "tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

}

variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in resource descriptions"
}
