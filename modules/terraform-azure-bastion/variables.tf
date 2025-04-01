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

# ------- Global settings -------
variable "tags" {
  type        = map(any)
  description = "Tags applied to provised resources."

  default = null
}

variable "bastion_region" {
  type        = string
  description = "Region which bastion will be created."
}

# ------- Bastion SG -------
variable "bastion_security_group_name" {
  type        = string
  description = "Name of bastion Security Group for CDP environment."
}

# ------- Bastion Network -------
variable "bastion_nic_name" {
  type        = string
  description = "Name of bastion network interface."
}

variable "bastion_pip_name" {
  type        = string
  description = "Name of Public IP."
}

variable "bastion_pip_static" {
  description = "Whether the Bastion Public IP should be Static (true) or Dynamic (false)."
  type        = bool

  default = true
}

variable "bastion_ipconfig_name" {
  type        = string
  description = "Name of bastion IP configuration."
}

variable "bastion_private_ip_static" {
  description = "Whether the Bastion Private IP should be Static (true) or Dynamic (false)."
  type        = bool

  default = false
}

variable "bastion_subnet_id" {
  type        = string
  description = "The ID of the subnet where the bastion VM will run."

}

# ------- Bastion VM Settings -------
variable "bastion_os_type" {
  type        = string
  description = "The operating system type for the Bastion VM. Options are 'Linux' or 'Windows'."

  default = "Linux"
}

variable "bastion_resourcegroup_name" {
  type        = string
  description = "Bastion resource group name."

}

variable "bastion_sa_type" {
  description = "Bastion OS disk storage type."
  type        = string

  default = "Standard_LRS"
}

variable "bastion_cache" {
  description = "Bastion OS disk caching."
  type        = string

  default = "ReadWrite"
}

variable "bastion_size" {
  description = "Bastion VM size."
  type        = string

  default = "Standard_F2"
}

variable "bastion_img_pub" {
  description = "Bastion OS image publisher. E.g., 'Canonical', 'MicrosoftWindowsServer'"
  type        = string

  default = "Canonical"
}

variable "bastion_img_offer" {
  description = "Bastion OS image offer. E.g., 'UbuntuServer', 'WindowsServer'"
  type        = string

  default = "UbuntuServer"
}

variable "bastion_img_sku" {
  description = "Bastion OS image SKU. E.g., '18.04-LTS', '2019-Datacenter'"
  type        = string

  default = "18.04-LTS"
}

variable "bastion_img_ver" {
  description = "Bastion OS image version."
  type        = string

  default = "latest"
}

variable "bastion_admin_username" {
  type        = string
  description = "The administrator username for the bastion host. This is used to log in to the instance."
}

variable "bastion_host_name" {
  type        = string
  description = "Name of bastion host."

}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the SSH public key. One of either admin_password or admin_ssh_key must be specified for Linux."
}

variable "bastion_admin_password" {
  description = "The administrator password for the bastion host. This is used to log in to the instance. Required for Windows. For Linux, if not null, will replace SSH authentication."
  type        = string

  default = null

  validation {
    condition     = var.bastion_os_type == "Linux" || (var.bastion_os_type == "Windows" && var.bastion_admin_password != null)
    error_message = "For Windows OS, 'bastion_admin_password' must be specified."
  }
}

variable "replace_on_user_data_change" {
  type        = bool
  description = "Trigger a destroy and recreate the VM when user_data changes."

  default = null
}

variable "bastion_user_data" {
  type        = string
  description = "Base64-encoded user data for the bastion instance."

  default = null
}
