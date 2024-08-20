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

# Find Availability Zones is AWS region
data "aws_availability_zones" "zones_in_region" {
  state = "available"
}

# Local variables for VPC creation
locals {
  # Calculate number of subnets based on the deployment_type
  subnets_required = {
    total   = (var.deployment_template == "public") ? length(data.aws_availability_zones.zones_in_region.names) : 2 * length(data.aws_availability_zones.zones_in_region.names)
    public  = length(data.aws_availability_zones.zones_in_region.names)
    private = (var.deployment_template == "public") ? 0 : length(data.aws_availability_zones.zones_in_region.names)
  }

  # Public Network infrastructure
  # 1 per AZ and conditional on local.subnets_required.public
  public_subnets = (local.subnets_required.public == 0 ?
    [] :
    [
      for idx, az in data.aws_availability_zones.zones_in_region.names :
      {
        name = "${var.env_prefix}-sbnt-pub-${format("%02d", idx + 1)}"
        az   = az
        cidr = cidrsubnet(var.vpc_cidr, ceil(log(local.subnets_required.total, 2)), idx)
        tags = {
          "kubernetes.io/role/elb" = "1",
          "Name"                   = "${var.env_prefix}-sbnt-pub-${format("%02d", idx + 1)}"
        }
      }
  ])

  # Private Network infrastructure
  # if not specified via TF var then calculate. 1 per AZ and conditional on local.subnets_required.private
  private_subnets = (local.subnets_required.private == 0 ?
    [] :
    [
      for idx, az in data.aws_availability_zones.zones_in_region.names :
      {
        name = "${var.env_prefix}-sbnt-pvt-${format("%02d", idx + 1)}"
        az   = az
        cidr = cidrsubnet(var.vpc_cidr, ceil(log(local.subnets_required.total, 2)), local.subnets_required.public + idx)
        tags = {
          "kubernetes.io/role/internal-elb" = "1",
          "Name"                            = "${var.env_prefix}-sbnt-pvt-${format("%02d", idx + 1)}"
        }
      }
  ])

}

# ------- VPC -------
# Create the VPC
resource "aws_vpc" "cdp_vpc" {
  cidr_block = var.vpc_cidr
  tags       = merge({ Name = "${var.env_prefix}-net" })

  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# ------- AWS Public Network infrastructure -------
# Internet Gateway
resource "aws_internet_gateway" "cdp_igw" {
  vpc_id = aws_vpc.cdp_vpc.id
  tags   = merge({ Name = "${var.env_prefix}-igw" })
}

# AWS VPC Public Subnets 
resource "aws_subnet" "cdp_public_subnets" {
  for_each = { for idx, subnet in local.public_subnets : idx => subnet }

  vpc_id                  = aws_vpc.cdp_vpc.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = true
  availability_zone       = each.value.az
  tags                    = each.value.tags
}

# Public Route Table
resource "aws_default_route_table" "cdp_public_route_table" {
  default_route_table_id = aws_vpc.cdp_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cdp_igw.id
  }

  tags = merge({ Name = "${var.env_prefix}-public-rtb" })

}

# Associate the Public Route Table with the Public Subnets
resource "aws_route_table_association" "cdp_public_subnets" {

  for_each = aws_subnet.cdp_public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_vpc.cdp_vpc.default_route_table_id
}

# ------- AWS Private Networking infrastructure -------

# AWS VPC Private Subnets
resource "aws_subnet" "cdp_private_subnets" {
  for_each = { for idx, subnet in local.private_subnets : idx => subnet }

  vpc_id                  = aws_vpc.cdp_vpc.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = false
  availability_zone       = each.value.az
  tags                    = each.value.tags
}

# Elastic IP for each NAT gateway
resource "aws_eip" "cdp_nat_gateway_eip" {

  for_each = { for idx, subnet in local.public_subnets : idx => subnet }

  domain = "vpc"
  tags   = { Name = format("%s-%s-%02d", "${var.env_prefix}-ngw", "eip", index(local.public_subnets, each.value) + 1) }
}

#  Network Gateways (NAT)
resource "aws_nat_gateway" "cdp_nat_gateway" {

  count = length(aws_subnet.cdp_public_subnets)

  subnet_id         = aws_subnet.cdp_public_subnets[count.index].id
  allocation_id     = aws_eip.cdp_nat_gateway_eip[count.index].id
  connectivity_type = "public"

  tags = { Name = format("%s-%02d", "${var.env_prefix}-ngw", count.index) }
}

# Private Route Tables
resource "aws_route_table" "cdp_private_route_table" {
  for_each = { for idx, subnet in local.private_subnets : idx => subnet }

  vpc_id = aws_vpc.cdp_vpc.id

  tags = { Name = format("%s-%02d", "${var.env_prefix}-private-rtb", index(local.private_subnets, each.value)) }

  route {
    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.cdp_nat_gateway[(index(local.private_subnets, each.value) % length(aws_nat_gateway.cdp_nat_gateway))].id

  }
}

# Associate the Private Route Tables with the Private Subnets
resource "aws_route_table_association" "cdp_private_subnets" {

  count = length(aws_subnet.cdp_private_subnets)

  subnet_id      = aws_subnet.cdp_private_subnets[count.index].id
  route_table_id = aws_route_table.cdp_private_route_table[count.index].id
}