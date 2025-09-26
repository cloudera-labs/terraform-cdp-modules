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

output "aws_security_group_default_id" {
  value = data.aws_security_group.cdp_default_sg.id

  description = "AWS security group id for default CDP SG"
}

output "aws_security_group_default_arn" {
  value = data.aws_security_group.cdp_default_sg.arn

  description = "AWS security group ARN for default CDP SG"
}

output "aws_security_group_knox_id" {
  value = data.aws_security_group.cdp_knox_sg.id

  description = "AWS security group id for Knox CDP SG"
}


output "aws_security_group_knox_arn" {
  value = data.aws_security_group.cdp_knox_sg.arn

  description = "AWS security group ARN for Knox CDP SG"
}

output "aws_prefix_list_id" {
  value = var.use_prefix_list_for_ingress ? aws_ec2_managed_prefix_list.cdp_prefix_list[0].id : null

  description = "AWS managed prefix list ID"
}
