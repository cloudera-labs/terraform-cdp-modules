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
  profile = var.aws_profile
  region  = var.aws_region
}

module "ex01_network_vpc" {
  source = "../../../terraform-aws-vpc"

  cdp_vpc            = false
  vpc_name           = "${var.name_prefix}-network-vpc"
  vpc_cidr           = "10.11.0.0/16"
  enable_nat_gateway = false

  private_cidr_range = var.network_vpc_private_cidr_range
  public_cidr_range  = var.network_vpc_public_cidr_range

}

module "ex01_proxy" {
  source = "../.."

  vpc_id = module.ex01_network_vpc.vpc_id

  proxy_security_group_name = "${var.name_prefix}-sg"
  proxy_aws_keypair_name    = var.aws_key_pair

  proxy_launch_template_name   = "${var.name_prefix}-lt"
  proxy_autoscaling_group_name = "${var.name_prefix}-asg"
  proxy_subnet_ids             = module.ex01_network_vpc.public_subnets

  network_load_balancer_name = "${var.name_prefix}-lb"
  target_group_proxy_name    = "${var.name_prefix}-tg"
  lb_subnet_ids              = module.ex01_network_vpc.private_subnets

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
      # to_port = 
      protocol = "tcp"
    }
  ]

  route_tables_to_update = [
    # Route all Internet traffic in Networking VPC to the proxy instance(s)
    {
      route_tables           = module.ex01_network_vpc.private_route_tables
      destination_cidr_block = "0.0.0.0/0"
    }
  ]

}
