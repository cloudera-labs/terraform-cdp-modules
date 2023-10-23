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
  value = azurerm_storage_share.nfs_storage_share.url
  description = "NFS File Share url"
}

output "nfs_vm_public_ip" {
  value = azurerm_public_ip.nfsvm_public_ip.ip_address
  description = "NFS VM public IP address"
}
