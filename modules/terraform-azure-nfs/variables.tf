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

  validation {
    condition     = length(var.nfs_file_share_name) >= 3 && length(var.nfs_file_share_name) <= 63
    error_message = "The length of nfs_file_share_name must be between 3 and 63 characters."
  }

  validation {
    condition     = can(regex("^[a-z0-9-]{1,63}$", var.nfs_file_share_name))
    error_message = "nfs_file_share_name can consist only of lowercase letters, numbers, hyphens (-)."
  }
}


variable "nfs_private_endpoint_target_subnet_names" {
  type        = list(string)
  description = "Subnet to which private endpoints are created"
}

variable "nfs_storage_account_name" {
  type        = string
  description = "NFS Storage account name"

  validation {
    condition     = (length(var.nfs_storage_account_name) >= 3 && length(var.nfs_storage_account_name) <= 24)
    error_message = "The length of nfs_storage_account_name must be between 3 and 24 characters."
  }
  validation {
    condition     = (can(regex("^[a-z0-9]{1,24}$", var.nfs_storage_account_name)))
    error_message = "nfs_storage_account_name can consist only of lowercase letters and numbers."
  }
}

variable "nfs_file_share_size" {
  type        = number
  description = "NFS File Share size"
  default     = 100

}

variable "nfs_vnet_link_name" {
  type        = string
  description = "Name for NFS VNET Link"
}

variable "nfsvm_public_ip_name" {
  type        = string
  description = "Name for NFS VM Public IP"
  default     = null

  validation {
    condition     = (var.nfsvm_public_ip_name == null ? true : length(var.nfsvm_public_ip_name) >= 1 && length(var.nfsvm_public_ip_name) <= 80)
    error_message = "The length of nfsvm_public_ip_name must be 80 characters or less."
  }

  validation {
    condition     = (var.nfsvm_public_ip_name == null ? true : can(regex("^[a-zA-Z0-9.-_]{1,80}$", var.nfsvm_public_ip_name)))
    error_message = "nfsvm_public_ip_name can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
  }
}

variable "nfsvm_nic_name" {
  type        = string
  description = "Name for NFS VM NIC"
  default     = null

  validation {
    condition     = (var.nfsvm_nic_name == null ? true : length(var.nfsvm_nic_name) >= 1 && length(var.nfsvm_nic_name) <= 80)
    error_message = "The length of nfsvm_nic_name must be 80 characters or less."
  }

  validation {
    condition     = (var.nfsvm_nic_name == null ? true : can(regex("^[a-zA-Z0-9.-_]{1,80}$", var.nfsvm_nic_name)))
    error_message = "nfsvm_public_ip_name can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
  }
}

variable "nfsvm_sg_name" {
  type        = string
  description = "Name for NFS VM Security Group"
  default     = null

  validation {
    condition     = (var.nfsvm_sg_name == null ? true : length(var.nfsvm_sg_name) >= 1 && length(var.nfsvm_sg_name) <= 80)
    error_message = "The length of nfsvm_sg_name must be 80 characters or less."
  }

  validation {
    condition     = (var.nfsvm_sg_name == null ? true : can(regex("^[a-zA-Z0-9.-_]{1,80}$", var.nfsvm_sg_name)))
    error_message = "nfsvm_sg_name can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
  }
}

variable "nfsvm_name" {
  type        = string
  description = "Name for NFS VM"
  default     = null

  validation {
    condition     = (var.nfsvm_name == null ? true : length(var.nfsvm_name) >= 1 && length(var.nfsvm_name) <= 64)
    error_message = "The length of nfsvm_name must be 64 characters or less."
  }

  validation {
    condition     = (var.nfsvm_name == null ? true : can(regex("^[a-zA-Z0-9.-_]{1,64}$", var.nfsvm_name)))
    error_message = "nfsvm_name can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
  }
}

variable "public_key_text" {
  type        = string
  description = "SSH Public key string for the nodes of the CDP environment"
  default     = null
}

variable "source_address_prefixes" {
  type        = list(string)
  description = "Source address prefixes for VM ssh access"
  default     = null
}

variable "create_vm_mounting_nfs" {
  type        = bool
  description = "Whether to create a VM which mounts this NFS"
  default     = true
}
