# Copyright 2025 Cloudera, Inc. All Rights Reserved.
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

resource "azurerm_network_security_group" "bastion_sg" {
  name                = var.bastion_security_group_name
  location            = var.bastion_region
  resource_group_name = var.bastion_resourcegroup_name
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "allow-ssh"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.bastion_resourcegroup_name
  network_security_group_name = azurerm_network_security_group.bastion_sg.name
}

resource "azurerm_subnet_network_security_group_association" "bastion_sg_association" {
  subnet_id                 = var.bastion_subnet_id
  network_security_group_id = azurerm_network_security_group.bastion_sg.id
}

resource "azurerm_public_ip" "bastion_pip" {
  name                = var.bastion_pip_name
  location            = var.bastion_region
  resource_group_name = var.bastion_resourcegroup_name
  allocation_method   = var.bastion_pip_static ? "Static" : "Dynamic"
}

resource "azurerm_network_interface" "bastion_nic" {
  name                = var.bastion_nic_name
  location            = var.bastion_region
  resource_group_name = var.bastion_resourcegroup_name

  ip_configuration {
    name                          = var.bastion_ipconfig_name
    subnet_id                     = var.bastion_subnet_id
    private_ip_address_allocation = var.bastion_private_ip_static ? "Static" : "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_pip.id
  }
}

resource "azurerm_linux_virtual_machine" "bastion" {
  count                 = var.bastion_os_type == "Linux" ? 1 : 0
  admin_username        = var.bastion_admin_username
  location              = var.bastion_region
  name                  = var.bastion_host_name
  network_interface_ids = [azurerm_network_interface.bastion_nic.id]

  os_disk {
    storage_account_type = var.bastion_sa_type
    caching              = var.bastion_cache
  }
  size                = var.bastion_size
  resource_group_name = var.bastion_resourcegroup_name

  source_image_reference {
    publisher = var.bastion_img_pub
    offer     = var.bastion_img_offer
    sku       = var.bastion_img_sku
    version   = var.bastion_img_ver
  }

  custom_data = var.replace_on_user_data_change == true ? var.bastion_user_data : null
  user_data   = var.replace_on_user_data_change == false ? var.bastion_user_data : null

  admin_password = var.bastion_admin_password != null ? var.bastion_admin_password : null
  admin_ssh_key {
    username   = var.bastion_admin_username
    public_key = file(var.ssh_public_key_path)
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "bastion" {
  count                 = var.bastion_os_type == "Windows" ? 1 : 0
  admin_username        = var.bastion_admin_username
  admin_password        = var.bastion_admin_password
  location              = var.bastion_region
  name                  = var.bastion_host_name
  network_interface_ids = [azurerm_network_interface.bastion_nic.id]

  os_disk {
    storage_account_type = var.bastion_sa_type
    caching              = var.bastion_cache
  }
  size                = var.bastion_size
  resource_group_name = var.bastion_resourcegroup_name

  source_image_reference {
    publisher = var.bastion_img_pub
    offer     = var.bastion_img_offer
    sku       = var.bastion_img_sku
    version   = var.bastion_img_ver
  }

  custom_data = var.replace_on_user_data_change == true ? var.bastion_user_data : null
  user_data   = var.replace_on_user_data_change == false ? var.bastion_user_data : null

  tags = var.tags
}