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

# Read remote state from step1
data "terraform_remote_state" "step1" {
  backend = "local"

  config = {
    path = "../step1_vpcs/terraform.tfstate"
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

# Use terraform_remote_state to retrieve CDP VPC details from step01
data "aws_vpc" "cdp_vpc_info" {
  id = data.terraform_remote_state.step1.outputs.ex01_cdp_vpc_id
}

module "ex01_tgw_basic" {
  source = "../../.."

  tgw_name = "${var.name_prefix}-tgw"

  vpc_attachments = {
    cdp_vpc = {
      vpc_id                 = data.terraform_remote_state.step1.outputs.ex01_cdp_vpc_id
      subnet_ids             = data.terraform_remote_state.step1.outputs.ex01_cdp_private_subnet_ids
      rt_propagation_key     = "network_vpc" # the vpc attachment key for the TGW Route Table association & propagation
      create_tgw_route_table = true          # create a dedicated TGW RT for the VPC attachment
      tgw_routes = [                         # List of TGW Routes to add
        {
          destination_cidr_block = "0.0.0.0/0"   # Destination CIDR
          route_attachment_key   = "network_vpc" # vpc attachment key
        }
      ]
      create_vpc_routes = true
      vpc_routes = [ # List of VPC Route Tables to update with TGW entry
        # Route all 0.0.0.0/0 traffic to Transit Gateway for all private subnet route tables in CDP VPC
        {
          route_tables           = data.terraform_remote_state.step1.outputs.ex01_cdp_private_route_table_ids
          destination_cidr_block = "0.0.0.0/0"
        }
      ]
    },
    network_vpc = {
      vpc_id                 = data.terraform_remote_state.step1.outputs.ex01_network_vpc_id
      subnet_ids             = data.terraform_remote_state.step1.outputs.ex01_network_private_subnet_ids
      rt_propagation_key     = "cdp_vpc"
      create_tgw_route_table = true # create a dedicated TGW RT for the VPC attachment
      create_vpc_routes      = true
      vpc_routes = [
        # All private subnet route tables will redirect CDP VPC CIDR traffic to Transit Gateway
        {
          route_tables           = concat(data.terraform_remote_state.step1.outputs.ex01_network_private_route_table_ids, data.terraform_remote_state.step1.outputs.ex01_network_public_route_table_ids)
          destination_cidr_block = data.aws_vpc.cdp_vpc_info.cidr_block_associations[0].cidr_block
        }
      ]
    }
  }

}
