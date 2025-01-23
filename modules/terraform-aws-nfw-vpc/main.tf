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

# ------- VPC -------
# Create the VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags       = merge({ Name = var.vpc_name })

  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge({ Name = "${var.vpc_name}-igw" })
}

# Public Route Table
resource "aws_default_route_table" "default_rt" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge({ Name = "${var.route_table_name_prefix}-public-rtb" })

}

# ------- Subnets for Transit Gateway -------
resource "aws_subnet" "tgw" {
  for_each = { for idx, subnet in local.tgw_subnets : idx => subnet }

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = false
  availability_zone       = each.value.az
  tags                    = merge(var.tags, { Name = each.value.name })
}

# Route Tables for Transit Gateway subnets
resource "aws_route_table" "tgw" {
  for_each = { for idx, subnet in local.tgw_subnets : idx => subnet }

  vpc_id = aws_vpc.vpc.id

  tags = { Name = format("%s-%02d", "${var.route_table_name_prefix}-tgw-rtb", index(local.tgw_subnets, each.value)) }
}

# Associate the Transit Gateway Route Tables with the TGW Subnets
resource "aws_route_table_association" "tgw" {

  count = length(aws_subnet.tgw)

  subnet_id      = aws_subnet.tgw[count.index].id
  route_table_id = aws_route_table.tgw[count.index].id
}

# ------- Subnets for Firewall -------
resource "aws_subnet" "fw" {
  for_each = { for idx, subnet in local.fw_subnets : idx => subnet }

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = false
  availability_zone       = each.value.az
  tags                    = merge(var.tags, { Name = each.value.name })
}

# Route Tables for Firewall subnets
resource "aws_route_table" "fw" {
  for_each = { for idx, subnet in local.fw_subnets : idx => subnet }

  vpc_id = aws_vpc.vpc.id

  tags = { Name = format("%s-%02d", "${var.route_table_name_prefix}-fw-rtb", index(local.fw_subnets, each.value)) }
}

# Associate the Firewall Route Tables with the Firewall Subnets
resource "aws_route_table_association" "fw" {

  count = length(aws_subnet.fw)

  subnet_id      = aws_subnet.fw[count.index].id
  route_table_id = aws_route_table.fw[count.index].id
}


# ------- Subnets for NAT -------
resource "aws_subnet" "nat" {
  for_each = { for idx, subnet in local.nat_subnets : idx => subnet }

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = false
  availability_zone       = each.value.az
  tags                    = merge(var.tags, { Name = each.value.name })
}

# Route Tables for Firewall subnets
resource "aws_route_table" "nat" {
  for_each = { for idx, subnet in local.nat_subnets : idx => subnet }

  vpc_id = aws_vpc.vpc.id

  tags = { Name = format("%s-%02d", "${var.route_table_name_prefix}-nat-rtb", index(local.nat_subnets, each.value)) }
}

# Associate the Firewall Route Tables with the Firewall Subnets
resource "aws_route_table_association" "nat" {

  count = length(aws_subnet.nat)

  subnet_id      = aws_subnet.nat[count.index].id
  route_table_id = aws_route_table.nat[count.index].id
}


# ------- NAT Gateway Configuration -------
# Elastic IP for each NAT gateway
resource "aws_eip" "nat_gateway_eip" {

  for_each = { for idx, subnet in local.nat_subnets : idx => subnet }

  domain = "vpc"
  tags   = { Name = format("%s-%s-%02d", "${var.nat_gateway_name_prefix}-ngw", "eip", index(local.nat_subnets, each.value) + 1) }
}

#  Network Gateways (NAT) for each NAT subnet
resource "aws_nat_gateway" "nat_gateway" {

  count = length(aws_subnet.nat)

  subnet_id         = aws_subnet.nat[count.index].id
  allocation_id     = aws_eip.nat_gateway_eip[count.index].id
  connectivity_type = "public"

  tags = { Name = format("%s-%02d", "${var.nat_gateway_name_prefix}-ngw", count.index) }
}

# ------- Route Table Entries -------
resource "aws_route" "fw_nat_rtb_rt" {

  count = length(local.fw_subnets)
  #   count = length(var.public_nat_cidr_block)

  route_table_id         = aws_route_table.fw[count.index].id
  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = element(aws_nat_gateway.nat_gateway[*].id, count.index)
}

# Route tables for NAT Subnets:
# 0.0.0.0/0 -> IGW
resource "aws_route" "nat_igw_rtb_rt" {

  for_each = aws_route_table.nat

  route_table_id         = each.value.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"

}
