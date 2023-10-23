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
  type        = string
  description = "Resource Group Name"
}

variable "vnet_name" {
  type        = string
  description = "Vnet name"

}


variable "azure_region" {
  type        = string
  description = "Region for CDP"

}

variable "private_endpoint_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in resource descriptions"
}


variable "nfs_file_share_name" {
  type        = string
  description = "nfs file share name"
}

variable "nfs_private_endpoint_target_subnet_names" {
  type        = list(string)
  description = "Subnets to which private endpoints are created"
}

variable "nfs_storage_account_name" {
  type        = string
  description = "NFS Storage account name"
}

variable "nfs_file_share_size" {
  type        = number
  description = "NFS File Share size"
}


variable "nfsvm_public_ip_name" {
  type        = string
  description = "Name for NFS VM Public IP"
}

variable "nfsvm_nic_name" {
  type        = string
  description = "Name for NFS VM NIC"
}

variable "nfsvm_sg_name" {
  type        = string
  description = "Name for NFS VM Security Group"
}

variable "nfs_vnet_link_name" {
  type        = string
  description = "Name for NFS VNET Link"
}


variable "nfsvm_name" {
  type        = string
  description = "Name for NFS VM"
}

variable "public_key_text" {
  type = string

  description = "SSH Public key string for the nodes of the CDP environment"
}

variable "source_address_prefixes" {
  type        = list(string)
  description = "Source address prefixes for VM ssh access"
}