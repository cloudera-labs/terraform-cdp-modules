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

# Find details of the VPC
data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_security_group" "cdp_default_sg" {

  name   = local.create_default_security_group ? aws_security_group.cdp_default_sg[0].name : var.existing_default_security_group_name
  vpc_id = var.vpc_id
}

data "aws_security_group" "cdp_knox_sg" {

  name   = local.create_knox_security_group ? aws_security_group.cdp_knox_sg[0].name : var.existing_knox_security_group_name
  vpc_id = var.vpc_id
}