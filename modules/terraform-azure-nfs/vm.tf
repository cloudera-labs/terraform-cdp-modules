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


resource "azurerm_public_ip" "nfsvm_public_ip" {
  count               = var.create_vm_mounting_nfs ? 1 : 0
  name                = var.nfsvm_public_ip_name
  resource_group_name = var.resourcegroup_name
  location            = var.azure_region
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "nfsvm_nic" {
  count               = var.create_vm_mounting_nfs ? 1 : 0
  name                = var.nfsvm_nic_name
  resource_group_name = var.resourcegroup_name
  location            = var.azure_region

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.nfs_subnets[var.nfs_private_endpoint_target_subnet_names[0]].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.nfsvm_public_ip[count.index].id
  }
}

resource "azurerm_network_security_group" "nfsvm_sg" {
  count               = var.create_vm_mounting_nfs ? 1 : 0
  name                = var.nfsvm_sg_name
  resource_group_name = var.resourcegroup_name
  location            = var.azure_region
}


resource "azurerm_network_security_rule" "nfsvm_sg_rule" {
  count                       = var.create_vm_mounting_nfs ? 1 : 0
  name                        = "allowssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = var.source_address_prefixes
  destination_address_prefix  = "*"
  resource_group_name         = var.resourcegroup_name
  network_security_group_name = azurerm_network_security_group.nfsvm_sg[count.index].name
}


resource "azurerm_network_interface_security_group_association" "nfsvm_nic_sg" {
  count                     = var.create_vm_mounting_nfs ? 1 : 0
  network_interface_id      = azurerm_network_interface.nfsvm_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.nfsvm_sg[count.index].id
}


resource "azurerm_linux_virtual_machine" "nfs_vm" {
  count               = var.create_vm_mounting_nfs ? 1 : 0
  name                = var.nfsvm_name
  resource_group_name = var.resourcegroup_name
  location            = var.azure_region
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nfsvm_nic[count.index].id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.public_key_text
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  custom_data = base64encode(templatefile("${path.module}/files/mount_nfs_on_vm.sh.tpl",
    { nfs_file_share_name = var.nfs_file_share_name
  nfs_storage_account_name = var.nfs_storage_account_name }))
}
