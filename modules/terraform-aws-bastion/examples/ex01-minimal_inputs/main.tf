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

module "ex01_network_vpc" {
  source = "../../../terraform-aws-vpc"

  cdp_vpc            = false
  vpc_name           = "${var.name_prefix}-network-vpc"
  vpc_cidr           = "10.11.0.0/16"
  enable_nat_gateway = false

  private_cidr_range = 26
  public_cidr_range  = 26
}

module "ex01_bastion" {
  source = "../.."

  vpc_id                   = module.ex01_network_vpc.vpc_id
  bastion_subnet_id        = module.ex01_network_vpc.public_subnets[0]
  bastion_aws_keypair_name = var.aws_key_pair

  bastion_user_data           = base64encode(file("./files/ex-bash.sh"))
  replace_on_user_data_change = true

  bastion_host_name           = "${var.name_prefix}-bastion"
  eip_name                    = "${var.name_prefix}-eip"
  bastion_security_group_name = "${var.name_prefix}-sg"
  ingress_rules = [
    {
      cidrs     = module.ex01_network_vpc.vpc_cidr_blocks
      from_port = 0
      to_port   = 65535
      protocol  = "tcp"
    },
    {
      cidrs     = var.ingress_extra_cidrs
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
    }
  ]
}
