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
variable "create_bastion_sg" {
  type        = bool
  description = "Flag to specify if the Security Group for the bastion should be created."

  default = true
}

variable "bastion_security_group_name" {
  type        = string
  description = "Name of bastion Security Group for CDP environment. Required when create_bastion_sg is true."

  default = null
}

variable "bastion_security_group_id" {
  type        = string
  description = "ID for existing Security Group to be used for the bastion VM. Required when create_bastion_sg is false."

  default = null
}

variable "ingress_rules" {
  description = "List of ingress rules to create."
  type = list(object({

    rule_name          = string
    description        = optional(string)
    protocol           = string
    src_port_range     = optional(string)
    src_port_ranges    = optional(list(string))
    dest_port_range    = optional(string)
    dest_port_ranges   = optional(list(string))
    src_addr_prefix    = optional(string)
    src_addr_prefixes  = optional(list(string))
    src_app_sg_ids     = optional(list(string))
    dest_addr_prefix   = optional(string)
    dest_addr_prefixes = optional(list(string))
    dest_app_sg_ids    = optional(list(string))
    priority           = number
  }))
  default = []
}

# ------- Bastion Network -------
variable "bastion_nic_name" {
  type        = string
  description = "Name of bastion network interface."
}

variable "bastion_public_ip_name" {
  type        = string
  description = "Name of Public IP."
}

variable "bastion_public_ip_static" {
  description = "Whether the Bastion Public IP should be Static (true) or Dynamic (false)."
  type        = bool

  default = false
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
  description = "The operating system type for the Bastion VM. Options are 'linux' or 'windows'."
  default     = "linux"

  validation {
    condition     = contains(["linux", "windows"], var.bastion_os_type)
    error_message = "Valid values for var: bastion_os_type are (linux, windows)."
  }
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

  default = "Standard_B1s"
}

variable "bastion_image_reference" {
  description = "The image reference for the bastion host."
  type = object({
    publisher = string # Bastion OS image publisher. E.g., 'Canonical', 'MicrosoftWindowsServer'
    offer     = string # Bastion OS image offer. E.g., 'UbuntuServer', 'WindowsServer'
    sku       = string # Bastion OS image SKU. E.g., '18.04-LTS', '2019-Datacenter'
    version   = string # Bastion OS image version.
  })

  default = {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}

variable "bastion_admin_username" {
  type        = string
  description = "The administrator username for the bastion host. This is used to log in to the instance."
}

variable "bastion_host_name" {
  type        = string
  description = "Name of bastion host."

  validation {
    condition     = length(var.bastion_host_name) <= 15
    error_message = "The bastion host name must be at most 15 characters."
  }
}

variable "public_key_text" {
  description = "The SSH public key for accessing the Linux bastion."
  type        = string
  default     = null

  validation {
    condition     = !(var.public_key_text != null && var.bastion_admin_password != null)
    error_message = "Do not define both public_key_text and bastion_admin_password."
  }
}

variable "bastion_admin_password" {
  description = "The admin password for the bastion. Required for Windows Bastion."
  type        = string

  default = null
}

variable "disable_pwd_auth" {
  description = "When an admin_password is specified, disable_password_authentication must be set to false."
  type        = bool

  default = true
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
