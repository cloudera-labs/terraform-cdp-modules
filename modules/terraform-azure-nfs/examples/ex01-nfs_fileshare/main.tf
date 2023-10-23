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

module "ex01_nfs_filesahre" {
  source = "../.."

  resourcegroup_name                      = var.resourcegroup_name
  azure_region                            = var.azure_region
  nfs_file_share_name                     = var.nfs_file_share_size
  nfs_file_share_size                     = var.nfs_file_share_size
  nfs_private_endpoint_target_subnet_name = var.nfs_private_endpoint_target_subnet_name
  vnet_name                               = var.vnet_name
  env_prefix                              = var.env_prefix
  nfs_storage_account_name                = var.nfs_storage_account_name

}

output "nfs_file_share_url" {
  value = module.ex01_nfs_filesahre.nfs_file_share_url
}
output "nfs_vm_public_ip" {
  value = module.ex01_nfs_filesahre.nfs_vm_public_ip
}