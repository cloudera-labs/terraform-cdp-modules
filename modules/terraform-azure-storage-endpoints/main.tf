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

resource "azurerm_private_dns_zone" "stor_privatednszone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resourcegroup_name

  tags = var.tags
}

resource "azurerm_private_endpoint" "private_endpoints" {

  for_each = { for idx, edp in local.endpoints_required : idx => edp }

  name                = format("%s-%02d", "${var.private_endpoint_prefix}-ept", index(local.endpoints_required, each.value) + 1)
  location            = var.azure_region
  resource_group_name = var.resourcegroup_name
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                           = "stor-privateserviceconnection"
    private_connection_resource_id = each.value.storage_account_id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name = "stor-dns-zone-group"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.stor_privatednszone.id
    ]
  }

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "stor_vnet_link" {
  name                  = "${var.private_endpoint_prefix}-vnet-link"
  resource_group_name   = var.resourcegroup_name
  private_dns_zone_name = azurerm_private_dns_zone.stor_privatednszone.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
}
