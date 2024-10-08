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


output "nfs_file_share_url" {
  value       = azurerm_storage_share.nfs_storage_share.url
  description = "NFS File Share url"
}

output "nfs_file_share_nfs_domain_url" {
  value       = "nfs://${var.nfs_storage_account_name}.file.core.windows.net/${var.nfs_storage_account_name}/${var.nfs_file_share_name}"

  description = "NFS File Share domain with nfs protocol prefix"
}


output "nfs_storage_account_name" {
  value       = azurerm_storage_account.nfs_storage_account.name
  description = "NFS Storage Account Name"
}

output "nfs_vm_public_ip" {
  value       = var.create_vm_mounting_nfs ? azurerm_public_ip.nfsvm_public_ip[0].ip_address : null
  description = "NFS VM public IP address"
}

output "nfs_vm_username" {
  value       = var.create_vm_mounting_nfs ? azurerm_linux_virtual_machine.nfs_vm[0].admin_username : null
  description = "NFS VM Admin Username"
}

output "nfs_vm_mount_path" {
  value       = var.create_vm_mounting_nfs ? "/mount/${var.nfs_storage_account_name}/${var.nfs_file_share_name}" : null
  description = "Path where NFS is mounted on the VM"
}

