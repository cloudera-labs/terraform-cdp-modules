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
  name = var.nfs_storage_account_name
  resource_group_name = var.resourcegroup_name
  location = var.azure_region
  account_tier = "Premium"
  account_replication_type = "LRS"
  account_kind = "FileStorage"
  enable_https_traffic_only = false
}


resource "azurerm_storage_share" "nfs_storage_share" {
  name = var.nfs_file_share_name
  storage_account_name = azurerm_storage_account.nfs_storage_account.name
  enabled_protocol = "NFS"
  quota = var.nfs_file_share_size
}


resource "azurerm_private_dns_zone" "nfs_privatednszone" {
  name = "privatelink.file.core.windows.net"
  resource_group_name = var.resourcegroup_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "nfs_vnet_link" {
  name = "${var.env_prefix}_vnetlink"
  resource_group_name = var.resourcegroup_name
  private_dns_zone_name = azurerm_private_dns_zone.nfs_privatednszone.name
  virtual_network_id = data.azurerm_virtual_network.nfs_vnet.id
}


resource "azurerm_private_endpoint" "nfs_private_endpoint" {
  name = "${var.env_prefix}_${data.azurerm_subnet.nfs_subnet.name}_nfs_private_endpoint"
  location = var.azure_region
  resource_group_name = var.resourcegroup_name
  subnet_id = data.azurerm_subnet.nfs_subnet.id

  private_service_connection {
    name = "nfs-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.nfs_storage_account.id
    subresource_names = [

      "file",
    ]
    is_manual_connection = false
  }

  private_dns_zone_group {
    name = "nfs-dns-zone-group"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.nfs_privatednszone.id]
  }
}

resource "azurerm_public_ip" "nfsvm_public_ip" {
  name = "${var.env_prefix}nfsvm-publicip"
  resource_group_name = var.resourcegroup_name
  location = var.azure_region
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_network_interface" "nfsvm_nic" {
  name = "${var.env_prefix}nfsvm-nic"
  resource_group_name = var.resourcegroup_name
  location = var.azure_region

  ip_configuration {
    name = "internal"
    subnet_id = data.azurerm_subnet.nfs_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.nfsvm_public_ip.id
  }
}

resource "azurerm_network_security_group" "nfsvm_sg" {
  name = "${var.env_prefix}nfsvm-sg"
  resource_group_name = var.resourcegroup_name
  location = var.azure_region

  security_rule {
    name = "allowssh"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nfsvm_nic_sg" {
  network_interface_id = azurerm_network_interface.nfsvm_nic.id
  network_security_group_id = azurerm_network_security_group.nfsvm_sg.id
}


resource "azurerm_linux_virtual_machine" "nfs_vm" {
  name = "${var.env_prefix}nfsvm"
  resource_group_name = var.resourcegroup_name
  location = var.azure_region
  size = "Standard_F2"
  admin_username = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nfsvm_nic.id,
  ]

  admin_ssh_key {
    username = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-focal"
    sku = "20_04-lts"
    version = "latest"
  }
}

