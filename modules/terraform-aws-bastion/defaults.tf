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

locals {

  # Security Groups
  bastion_security_group_id = (var.create_bastion_sg ?
  aws_security_group.bastion_sg[0].id : var.bastion_security_group_id)

  # Bastion VM
  bastion_aws_ami = coalesce(var.bastion_aws_ami, data.aws_ami.bastion_default_ami.id)

}