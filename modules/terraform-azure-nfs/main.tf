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

resource "azurerm_storage_account" "nfs_storage_account" {
  name                       = var.nfs_storage_account_name
  resource_group_name        = var.resourcegroup_name
  location                   = var.azure_region
  account_tier               = "Premium"
  account_replication_type   = "LRS"
  account_kind               = "FileStorage"
  https_traffic_only_enabled = false
}


resource "azurerm_storage_share" "nfs_storage_share" {
  name                 = var.nfs_file_share_name
  storage_account_name = azurerm_storage_account.nfs_storage_account.name
  enabled_protocol     = "NFS"
  quota                = var.nfs_file_share_size
}


resource "azurerm_private_dns_zone" "nfs_privatednszone" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = var.resourcegroup_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "nfs_vnet_link" {
  name                  = var.nfs_vnet_link_name
  resource_group_name   = var.resourcegroup_name
  private_dns_zone_name = azurerm_private_dns_zone.nfs_privatednszone.name
  virtual_network_id    = data.azurerm_virtual_network.nfs_vnet.id
}


resource "azurerm_private_endpoint" "nfs_private_endpoint" {

  for_each = data.azurerm_subnet.nfs_subnets

  name                = "${var.private_endpoint_prefix}_${each.value.name}_nfs_private_endpoint"
  location            = var.azure_region
  resource_group_name = var.resourcegroup_name
  subnet_id           = each.value.id

  private_service_connection {
    name                           = "nfs-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.nfs_storage_account.id
    subresource_names = [

      "file",
    ]
    is_manual_connection = false
  }

  private_dns_zone_group {
    name = "nfs-dns-zone-group"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.nfs_privatednszone.id
    ]
  }
}
