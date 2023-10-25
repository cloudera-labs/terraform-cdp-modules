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

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "ex01_nfs_fileshare" {
  source = "../.."

  resourcegroup_name                       = var.resourcegroup_name
  azure_region                             = var.azure_region
  nfs_file_share_name                      = var.nfs_file_share_name
  nfs_file_share_size                      = var.nfs_file_share_size
  nfs_private_endpoint_target_subnet_names = var.nfs_private_endpoint_target_subnet_names
  vnet_name                                = var.vnet_name
  nfs_storage_account_name                 = var.nfs_storage_account_name
  source_address_prefixes                  = var.source_address_prefixes
  nfsvm_nic_name                           = var.nfsvm_nic_name
  nfsvm_public_ip_name                     = var.nfsvm_public_ip_name
  nfsvm_sg_name                            = var.nfsvm_sg_name
  nfs_vnet_link_name                       = var.nfs_vnet_link_name
  nfsvm_name                               = var.nfsvm_name
  public_key_text                          = var.public_key_text
  private_endpoint_prefix                  = var.private_endpoint_prefix
}

output "nfs_file_share_url" {
  value = module.ex01_nfs_fileshare.nfs_file_share_url
}
output "nfs_vm_public_ip" {
  value = module.ex01_nfs_fileshare.nfs_vm_public_ip
}


output "nfs_vm_username" {
  value       = module.ex01_nfs_fileshare.nfs_vm_username
  description = "NFS VM Admin Username"
}

output "nfs_vm_mount_path" {
  value       = module.ex01_nfs_fileshare.nfs_vm_mount_path
  description = "Path where NFS is mounted on the VM"
}