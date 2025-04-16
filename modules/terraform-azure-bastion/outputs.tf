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

output "bastion_instance_public_ip" {
  description = "The public IP address of the Bastion instance."
  value       = azurerm_public_ip.bastion_pip.ip_address
}

output "linux_ssh_command" {
  description = "For Linux, SSH command required to connect to the Bastion host using the admin username and the public IP address."
  value       = "ssh ${var.bastion_admin_username}@${azurerm_public_ip.bastion_pip.ip_address}"
}

output "bastion_instance_private_ip" {
  description = "The private IP address of the Bastion instance."
  value       = var.bastion_os_type == "linux" ? azurerm_linux_virtual_machine.bastion[0].private_ip_address : azurerm_windows_virtual_machine.bastion[0].private_ip_address
}

output "bastion_instance_details" {
  description = "The details of the Bastion instance."
  value       = var.bastion_os_type == "linux" ? azurerm_linux_virtual_machine.bastion[0] : azurerm_windows_virtual_machine.bastion[0]
}

output "bastion_instance_id" {
  description = "The ID of the Bastion instance."
  value       = var.bastion_os_type == "linux" ? azurerm_linux_virtual_machine.bastion[0].id : azurerm_windows_virtual_machine.bastion[0].id
}