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

# Bastion port
output "bastion_port" {
  value = module.ex01_bastion.bastion_port

  description = "Port where Bastion is running"
}

# Bastion public IP
output "bastion_instance_public_ip" {
  value       = module.ex01_bastion.bastion_instance_public_ip
  
  description = "The public IP assigned to the Bastion host"
}

output "bastion_ingress_rules" {
  value = module.ex01_bastion.bastion_ingress_rules
  description = "Ingress security group rules for Bastion security group"
}

output "bastion_egress_rules" {
  value = module.ex01_bastion.bastion_egress_rules
  description = "Egress security group rules for Bastion security group"
}

output "create_bastion_sg" {
  value = module.ex01_bastion.create_bastion_sg
}

output "bastion_security_group_id" {
  value = module.ex01_bastion.bastion_security_group_id
}

output "bastion_user_data" {
  value = module.ex01_bastion.bastion_user_data
}
