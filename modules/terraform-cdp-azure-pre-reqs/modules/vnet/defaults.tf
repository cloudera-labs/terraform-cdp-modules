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

  # Calculate subnets CIDR and names
  subnets_required = {
    total             = (var.deployment_template == "semi-private") ? var.subnet_count + 1 : var.subnet_count
    cdp_subnets       = var.subnet_count
    gateway_subnets   = (var.deployment_template == "semi-private") ? 1 : 0
    delegated_subnets = (var.deployment_template != "public") ? 1 : 0
  }

  # Extract the VNet CIDR range from the user-provided CIDR
  vnet_cidr_range = split("/", var.vnet_cidr)[1]

  # Calculate the first suitable CIDR range for public subnets after private subnets have been allocated (normalize the offset, expressed as a multiplier of gateway subnet ranges)
  gateway_subnet_offset = ceil(local.subnets_required.cdp_subnets * pow(2, 32 - var.cdp_subnet_range) / pow(2, 32 - var.gateway_subnet_range))

  # Similar calculation for the first suitable CIDR range for delegated subnets after private subnets and public have been allocated (normalize the offset, expressed as a multiplier of gateway subnet ranges)
  delegated_subnet_offset = ceil(((local.subnets_required.cdp_subnets * pow(2, 32 - var.cdp_subnet_range)) + (local.subnets_required.gateway_subnets * pow(2, 32 - var.gateway_subnet_range))) / pow(2, 32 - var.delegated_subnet_range))

  # Network infrastructure for CDP resources
  cdp_subnets = [
    for idx in range(local.subnets_required.cdp_subnets) :
    {
      name = "${var.env_prefix}-sbnt-${format("%02d", idx + 1)}"
      cidr = cidrsubnet(var.vnet_cidr, var.cdp_subnet_range - local.vnet_cidr_range, idx)
    }
  ]

  # Network infrastructure for CDP resources
  gw_subnets = [
    for idx in range(local.subnets_required.gateway_subnets) :
    {
      name = "${var.env_prefix}-gw-sbnt-${format("%02d", idx + 1)}"
      cidr = cidrsubnet(var.vnet_cidr, var.gateway_subnet_range - local.vnet_cidr_range, idx + local.gateway_subnet_offset)
    }
  ]

  delegated_subnets = [
    for idx in range(local.subnets_required.delegated_subnets) :
    {
      name = "${var.env_prefix}-delegated-sbnt-${format("%02d", idx + 1)}"
      cidr = cidrsubnet(var.vnet_cidr, var.delegated_subnet_range - local.vnet_cidr_range, idx + local.delegated_subnet_offset)
    }
  ]

}