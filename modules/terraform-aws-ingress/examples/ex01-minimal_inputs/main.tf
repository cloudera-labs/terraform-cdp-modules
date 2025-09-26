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

provider "aws" {
  region = var.aws_region
}

module "ex01_vpc" {
  source = "../../../terraform-aws-vpc"

  cdp_vpc            = false
  vpc_name           = "${var.name_prefix}-vpc"
  vpc_cidr           = "10.11.0.0/16"
  enable_nat_gateway = false

  private_cidr_range = 26
  public_cidr_range  = 26
}

module "ex01_sg" {
  source = "../.."

  vpc_id = module.ex01_vpc.vpc_id

  default_security_group_name = "${var.name_prefix}-default-sg"
  knox_security_group_name    = "${var.name_prefix}-knox-sg"
  prefix_list_name            = "${var.name_prefix}-prefix-list"
  # use_prefix_list_for_ingress = false

  ingress_vpc_cidr = module.ex01_vpc.vpc_cidr_blocks[0]

  ingress_extra_cidrs_and_ports = var.ingress_extra_cidrs_and_ports


  tags = var.tags

  depends_on = [module.ex01_vpc]

}
