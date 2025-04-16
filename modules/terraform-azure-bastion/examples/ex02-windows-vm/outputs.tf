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
  value = module.ex02_bastion.bastion_instance_public_ip

  description = "The public IP assigned to the Bastion host."
}

output "bastion_instance_private_ip" {
  value = module.ex02_bastion.bastion_instance_private_ip

  description = "The private IP assigned to the Bastion host."
}

output "bastion_instance_details" {
  value = module.ex02_bastion.bastion_instance_details

  description = "The details of the Bastion host."
  sensitive   = true
}

output "bastion_instance_id" {
  value = module.ex02_bastion.bastion_instance_id

  description = "The instance ID assigned to the Bastion host."
}

output "bastion_admin_username" {
  value = module.ex02_bastion.bastion_admin_username

  description = "The administrator username for the bastion host. This is used to log in to the instance."
}