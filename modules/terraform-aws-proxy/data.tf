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

# Find AWS region
data "aws_region" "current" {}

# Find AMI for default proxy VMs
data "aws_ami" "proxy_default_ami" {

  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  owners = ["amazon"]
}

# Find details of the VPC
data "aws_vpc" "proxy_vpc" {
  id = var.vpc_id
}

# Find the network interface for the load balancer
data "aws_network_interface" "proxy_lb" {

  for_each = { for k, v in var.lb_subnet_ids : k => v }

  filter {
    name   = "description"
    values = ["ELB ${aws_lb.proxy_lb.arn_suffix}"]
  }

  filter {
    name   = "subnet-id"
    values = [each.value]
  }
}

# Find route table details
data "aws_route_table" "proxy_rt" {

  for_each = {
    for k, v in local.route_tables_to_update : k => v
  }

  route_table_id = each.value.route_table

}