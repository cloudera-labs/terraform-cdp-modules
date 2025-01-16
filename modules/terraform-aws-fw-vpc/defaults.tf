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

locals {

  # Create a list of supported zones in the region
  zones_in_region = tolist(data.aws_availability_zones.zones_in_region.names)

  # ------- Determine subnet details from inputs -------
  subnets_required = {
    total       = (3 * length(local.zones_in_region))
    tgw_subnets = length(local.zones_in_region)
    fw_subnets  = length(local.zones_in_region)
    nat_subnets = length(local.zones_in_region)
  }

  # Extract the VPC CIDR range from the user-provided CIDR
  vpc_cidr_range = split("/", var.vpc_cidr)[1]

  tgw_subnets = [
    for idx in range(local.subnets_required.tgw_subnets) :
    {
      name = "${var.subnet_name_prefix}-tgw-sbnt-${format("%02d", idx + 1)}"
      az   = local.zones_in_region[idx % length(local.zones_in_region)]
      cidr = cidrsubnet(var.vpc_cidr, var.tgw_cidr_range - local.vpc_cidr_range, idx)
    }
  ]

  # Calculate the first suitable CIDR range for Firewall subnets after Transit Gateway subnets have been allocated (normalize the offset, expressed as a multiplier of TGW subnet ranges)
  fw_subnet_offset = ceil(local.subnets_required.fw_subnets * pow(2, 32 - var.fw_cidr_range) / pow(2, 32 - var.tgw_cidr_range))
  fw_subnets = [
    for idx in range(local.subnets_required.fw_subnets) :
    {
      name = "${var.subnet_name_prefix}-fw-sbnt-${format("%02d", idx + 1)}"
      az   = local.zones_in_region[idx % length(local.zones_in_region)]
      cidr = cidrsubnet(var.vpc_cidr, var.fw_cidr_range - local.vpc_cidr_range, idx + local.fw_subnet_offset)
    }
  ]

  # Calculate the first suitable CIDR range for NAT subnets after Transit Gateway subnets have been allocated (normalize the offset, expressed as a multiplier of TGW subnet ranges)
  nat_subnet_offset = (ceil(local.subnets_required.nat_subnets * pow(2, 32 - var.nat_cidr_range) / pow(2, 32 - var.tgw_cidr_range))) + local.fw_subnet_offset
  nat_subnets = [
    for idx in range(local.subnets_required.nat_subnets) :
    {
      name = "${var.subnet_name_prefix}-nat-sbnt-${format("%02d", idx + 1)}"
      az   = local.zones_in_region[idx % length(local.zones_in_region)]
      cidr = cidrsubnet(var.vpc_cidr, var.nat_cidr_range - local.vpc_cidr_range, idx + local.nat_subnet_offset)
    }
  ]

}
