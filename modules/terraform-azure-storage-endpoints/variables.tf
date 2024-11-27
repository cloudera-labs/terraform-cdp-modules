# Copyright 2024 Cloudera, Inc. All Rights Reserved.
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

variable "resourcegroup_name" {
  type        = string
  description = "Pre-existing Resource Group Name"
}

variable "tags" {
  type        = map(any)
  description = "Tags applied to VPC resources. Only used when create_vpc is true."

  default = null
}

variable "vnet_name" {
  type        = string
  description = "Pre-existing Vnet name"

}

variable "azure_region" {
  type        = string
  description = "Region for the private endpoints"

}

variable "private_endpoint_prefix" {
  type        = string
  description = "Shorthand name for the private endpoint resources. Used in resource descriptions"

  validation {
    condition     = length(var.private_endpoint_prefix) <= 12
    error_message = "The length of private_endpoint_prefix must be 12 characters or less."
  }
}

variable "private_endpoint_target_subnet_ids" {
  type        = list(string)
  description = "List of subnet ids to which private endpoints are created"
}

variable "private_endpoint_storage_account_ids" {
  type        = list(string)
  description = "List of storage account ids to which private endpoints are created"
}