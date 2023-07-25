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

module "networking_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "${var.env_prefix}-network-vpc"
  cidr = var.vpc_cidr

  azs = [for v in data.aws_availability_zones.zones_in_region.names : v]
  private_subnets = (local.subnets_required.private == 0 ?
    [] :
    [
      for k, v in data.aws_availability_zones.zones_in_region.names : cidrsubnet(var.vpc_cidr, ceil(log(local.subnets_required.total, 2)), local.subnets_required.public + k)
    ]
  )

  public_subnets = (local.subnets_required.public == 0 ?
    [] :
    [
      for k, v in data.aws_availability_zones.zones_in_region.names : cidrsubnet(var.vpc_cidr, ceil(log(local.subnets_required.total, 2)), k)
    ]
  )

  enable_nat_gateway   = var.enable_nat_gateway
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = var.env_tags
}
