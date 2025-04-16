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

resource "azurerm_public_ip" "bastion_pip" {
  name                = var.bastion_public_ip_name
  location            = var.azure_region
  resource_group_name = var.bastion_resourcegroup_name
  allocation_method   = var.use_static_public_ip ? "Static" : "Dynamic"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion_host_name
  location            = var.azure_region
  resource_group_name = var.bastion_resourcegroup_name

  ip_configuration {
    name                 = var.bastion_ipconfig_name
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }

  tags = var.tags
}
