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


variable "resourcegroup_name" {
  type = string
  description = "Resource Group Name"
}

variable "vnet_name" {
  type = string
  description = "Vnet name"

}


variable "azure_region" {
  type = string
  description = "Region for CDP"

}

variable "env_prefix" {
  type = string
  description = "Shorthand name for the environment. Used in resource descriptions"
}


variable "nfs_file_share_name" {
  type = string
  description = "nfs file share name"
}

variable "nfs_private_endpoint_target_subnet_name" {
  type = string
  description = "Subnet to which private endpoint is created"
}

variable "nfs_storage_account_name" {
  type = string
  description = "NFS Storage account name"
}

variable "nfs_file_share_size" {
  type = number
  description = "NFS File Share size"
}