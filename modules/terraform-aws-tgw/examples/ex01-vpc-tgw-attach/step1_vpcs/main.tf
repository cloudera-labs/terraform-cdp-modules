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

module "ex01_cdp_vpc" {
  source = "../../../../terraform-aws-vpc"

  deployment_template        = "private"
  vpc_name                   = "${var.name_prefix}-cdp-vpc"
  vpc_cidr                   = "10.10.0.0/16"
  private_network_extensions = false

  tags = var.env_tags

  private_cidr_range = var.cdp_vpc_private_cidr_range
  public_cidr_range  = var.cdp_vpc_public_cidr_range

}

module "ex01_network_vpc" {
  source = "../../../../terraform-aws-vpc"

  cdp_vpc            = false
  vpc_name           = "${var.name_prefix}-network-vpc"
  vpc_cidr           = "10.11.0.0/16"
  enable_nat_gateway = false

  private_cidr_range = var.network_vpc_private_cidr_range
  public_cidr_range  = var.network_vpc_public_cidr_range

}
