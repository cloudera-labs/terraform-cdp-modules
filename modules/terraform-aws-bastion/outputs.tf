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

# Bastion public IP
output "bastion_instance_public_ip" {
  description = "The public IP address of the Bastion instance."
  value       = var.create_eip ? aws_eip.bastion_eip[0].public_ip : aws_instance.bastion.public_ip
}

output "bastion_instance_private_ip" {
  description = "The private IP address of the Bastion instance."
  value       = aws_instance.bastion.private_ip
}

output "bastion_instance_details" {
  description = "The details of the Bastion instance."
  value       = aws_instance.bastion
}

output "bastion_instance_id" {
  description = "The ID of the Bastion instance."
  value       = aws_instance.bastion.id
}

output "bastion_password_data" {
  description = "The password data for the Bastion instance."
  value = try(aws_instance.bastion.password_data,null)
}