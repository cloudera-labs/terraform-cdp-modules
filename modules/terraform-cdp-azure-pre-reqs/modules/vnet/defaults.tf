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
    total           = (var.deployment_template == "semi-private") ? var.subnet_count + 1 : var.subnet_count
    cdp_subnets     = var.subnet_count
    gateway_subnets = (var.deployment_template == "semi-private") ? 1 : 0
    # name            = "${var.env_prefix}-sbnt-${format("%02d", idx + 1)}"
    # cidr            = cidrsubnet(var.vnet_cidr, ceil(log(var.subnet_count, 2)), idx)
  }

  # Network infrastructure for CDP resources
  cdp_subnets = [
    for idx in range(local.subnets_required.cdp_subnets) :
    {
      name = "${var.env_prefix}-sbnt-${format("%02d", idx + 1)}"
      cidr = cidrsubnet(var.vnet_cidr, ceil(log(local.subnets_required.total, 2)), idx)
    }
  ]

  # Network infrastructure for CDP resources
  gw_subnets = [
    for idx in range(local.subnets_required.gateway_subnets) :
    {
      name = "${var.env_prefix}-gw-sbnt-${format("%02d", idx + 1)}"
      cidr = cidrsubnet(var.vnet_cidr, ceil(log(local.subnets_required.total, 2)), local.subnets_required.cdp_subnets + idx)
    }
  ]

}