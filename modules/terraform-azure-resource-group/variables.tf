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

variable "create_resource_group" {
  type = bool

  description = "Flag to specify if the Resource Group should be created. Otherwise data sources will be used to lookup details of existing resources."

  default = true
}

variable "resourcegroup_name" {
  type        = string
  description = "Resource Group name"

  default = null

  validation {
    condition     = (var.resourcegroup_name == null ? true : length(var.resourcegroup_name) >= 1 && length(var.resourcegroup_name) <= 90)
    error_message = "The length of resourcegroup_name must be 90 characters or less."
  }

  validation {
    condition     = (var.resourcegroup_name == null ? true : can(regex("^[a-zA-Z0-9\\-\\_\\.]{1,90}$", var.resourcegroup_name)))
    error_message = "resourcegroup_name can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
  }

}

variable "azure_region" {
  type        = string
  description = "Region which Resource Group will be created"

  default = null
}

variable "tags" {
  type        = map(any)
  description = "Tags applied to provisioned resources"

  default = null
}

# IDs for existing resources (used when create_resource_group = false)
variable "existing_resource_group_name" {
  type        = string
  description = "Name of existing VNet. Required if create_resource_group is false."

  default = null
}
