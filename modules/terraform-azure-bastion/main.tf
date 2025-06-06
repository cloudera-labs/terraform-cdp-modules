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
  count = var.create_bastion_sg ? 1 : 0

  name                = var.bastion_security_group_name
  location            = var.bastion_region
  resource_group_name = var.bastion_resourcegroup_name
}

resource "azurerm_network_security_rule" "ingress_rule" {
  for_each = { for k, v in var.ingress_rules : k => v
    if var.create_bastion_sg
  }

  direction                   = "Inbound"
  access                      = "Allow"
  resource_group_name         = var.bastion_resourcegroup_name
  network_security_group_name = azurerm_network_security_group.bastion_sg[0].name

  name                                       = each.value.rule_name
  description                                = try(each.value.description, null)
  protocol                                   = each.value.protocol
  source_port_range                          = try(each.value.src_port_range, null)
  source_port_ranges                         = try(each.value.src_port_ranges, null)
  destination_port_range                     = try(each.value.dest_port_range, null)
  destination_port_ranges                    = try(each.value.dest_port_ranges, null)
  source_address_prefix                      = try(each.value.src_addr_prefix, null)
  source_address_prefixes                    = try(each.value.src_addr_prefixes, null)
  source_application_security_group_ids      = try(each.value.src_app_sg_ids, null)
  destination_address_prefix                 = try(each.value.dest_addr_prefix, null)
  destination_address_prefixes               = try(each.value.dest_addr_prefixes, null)
  destination_application_security_group_ids = try(each.value.dest_app_sg_ids, null)
  priority                                   = each.value.priority
}

resource "azurerm_subnet_network_security_group_association" "bastion_sg_association" {
  subnet_id                 = var.bastion_subnet_id
  network_security_group_id = local.bastion_security_group_id
}

resource "azurerm_public_ip" "bastion_pip" {
  name                = var.bastion_public_ip_name
  location            = var.bastion_region
  resource_group_name = var.bastion_resourcegroup_name
  allocation_method   = var.bastion_public_ip_static ? "Static" : "Dynamic"
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

# ------- Bastion VMs
resource "azurerm_linux_virtual_machine" "bastion" {
  count                 = var.bastion_os_type == "linux" ? 1 : 0
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
    publisher = var.bastion_image_reference.publisher
    offer     = var.bastion_image_reference.offer
    sku       = var.bastion_image_reference.sku
    version   = var.bastion_image_reference.version
  }

  custom_data = var.replace_on_user_data_change == true ? var.bastion_user_data : null
  user_data   = var.replace_on_user_data_change == false ? var.bastion_user_data : null

  admin_password                  = var.bastion_admin_password
  disable_password_authentication = var.disable_pwd_auth
  # Conditionally include the SSH key block only if password is not provided
  dynamic "admin_ssh_key" {
    for_each = var.bastion_admin_password == null ? [1] : []
    content {
      username   = var.bastion_admin_username
      public_key = var.public_key_text
    }
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "bastion" {
  count                 = var.bastion_os_type == "windows" ? 1 : 0
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
    publisher = var.bastion_image_reference.publisher
    offer     = var.bastion_image_reference.offer
    sku       = var.bastion_image_reference.sku
    version   = var.bastion_image_reference.version
  }

  custom_data = var.replace_on_user_data_change == true ? var.bastion_user_data : null
  user_data   = var.replace_on_user_data_change == false ? var.bastion_user_data : null

  tags = var.tags
}