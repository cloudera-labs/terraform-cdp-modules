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
module "cdp_vpc" {
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
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  public_subnets = (local.subnets_required.public == 0 ?
    [] :
    [
      for i in range(local.subnets_required.public) : cidrsubnet(var.vpc_cidr, var.public_cidr_range - local.vpc_cidr_range, i + local.public_subnet_offset)
    ]
  )

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  enable_nat_gateway   = (var.deployment_template == "private") ? (var.private_network_extensions ? true : false) : true
  single_nat_gateway   = (var.deployment_template == "private") ? (var.private_network_extensions ? true : false) : false
  enable_dns_support   = true
  enable_dns_hostnames = true

  map_public_ip_on_launch = var.vpc_public_subnets_map_public_ip_on_launch

  public_inbound_acl_rules   = var.vpc_public_inbound_acl_rules
  public_outbound_acl_rules  = var.vpc_public_outbound_acl_rules
  private_inbound_acl_rules  = var.vpc_private_inbound_acl_rules
  private_outbound_acl_rules = var.vpc_private_outbound_acl_rules

  tags = var.tags
}
