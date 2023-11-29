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

#tfsec:ignore:aws-ec2-no-excessive-port-access
#tfsec:ignore:aws-ec2-no-public-ingress-acl
#tfsec:ignore:aws-ec2-no-public-ip-subnet
module "vpc" {
  count = var.create_vpc ? 1 : 0

  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs = [for v in local.zones_in_region : v]

  private_subnets = (local.subnets_required.private == 0 ?
    [] :
    [
      for i in range(local.subnets_required.private) : cidrsubnet(var.vpc_cidr, var.private_cidr_range - local.vpc_cidr_range, i)
    ]
  )
  private_subnet_tags = local.private_subnet_tags

  public_subnets = (local.subnets_required.public == 0 ?
    [] :
    [
      for i in range(local.subnets_required.public) : cidrsubnet(var.vpc_cidr, var.public_cidr_range - local.vpc_cidr_range, i + local.public_subnet_offset)
    ]
  )
  public_subnet_tags = local.public_subnet_tags

  enable_nat_gateway   = local.enable_nat_gateway
  single_nat_gateway   = local.single_nat_gateway
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  map_public_ip_on_launch = var.vpc_public_subnets_map_public_ip_on_launch

  public_inbound_acl_rules   = var.vpc_public_inbound_acl_rules
  public_outbound_acl_rules  = var.vpc_public_outbound_acl_rules
  private_inbound_acl_rules  = var.vpc_private_inbound_acl_rules
  private_outbound_acl_rules = var.vpc_private_outbound_acl_rules

  tags = var.tags
}
