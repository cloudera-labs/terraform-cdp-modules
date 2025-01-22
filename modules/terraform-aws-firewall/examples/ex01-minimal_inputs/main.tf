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

provider "aws" {
  region = var.aws_region
}

module "ex01_network_vpc" {
  source = "../../../terraform-aws-nfw-vpc"

  vpc_name = "${var.name_prefix}-network-vpc"

  subnet_name_prefix      = var.name_prefix
  nat_gateway_name_prefix = var.name_prefix
  route_table_name_prefix = var.name_prefix

  vpc_cidr = var.vpc_cidr

  tags = var.env_tags

}

module "ex01_nfw" {
  source = "../.."

  cdp_firewall_rule_group_name = "${var.name_prefix}-cdp-rg"
  firewall_policy_name         = "${var.name_prefix}-fwp"
  firewall_name                = "${var.name_prefix}-fw"

  cdp_vpc_id     = module.ex01_network_vpc.vpc_id
  network_vpc_id = module.ex01_network_vpc.vpc_id

  firewall_subnet_ids = module.ex01_network_vpc.fw_subnet_ids

  # route_tables_to_update = []

  tags = var.env_tags


}
