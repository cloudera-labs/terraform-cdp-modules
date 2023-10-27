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

  # AWS region (derived from provider lookup unless overridden)
  aws_region = coalesce(var.aws_region, data.aws_region.current.name)

  # Security Groups
  proxy_security_group_id = (var.create_proxy_sg ?
  aws_security_group.proxy_sg[0].id : var.proxy_security_group_id)

  # Proxy VM
  proxy_aws_ami = coalesce(var.proxy_aws_ami, data.aws_ami.proxy_default_ami.id)

  # User data for Proxy VM (for squid proxy)
  proxy_launch_template_user_data_file = coalesce(var.proxy_launch_template_user_data_file, "${path.module}/files/squid-user-data.sh.tpl")

  # Squid whitelist file
  proxy_whitelist_file = coalesce(var.proxy_whitelist_file, "${path.module}/files/squid-whitelist.txt.tpl")

  # Local variables to determine route table to Internal NLB eni mapping
  route_tables_to_update = flatten([
    for route in var.route_tables_to_update :
    [
      for rt in route.route_tables :
      {
        route_table            = rt
        destination_cidr_block = route.destination_cidr_block
      }
    ]
  ])

  lb_eni_details = [
    for eni in data.aws_network_interface.proxy_lb :
    {
      eni_id    = eni.id
      az        = eni.availability_zone
      subnet_id = eni.subnet_id
    }
  ]

  # TODO: Explore better rt to eni mapping with the below
  # route_table_details = [
  #   for rt in data.aws_route_table.proxy_rt :
  #   {
  #     rt_id      = rt.id
  #     subnet_ids = rt.associations[*].subnet_id
  #   }
  # ]

  route_table_to_lb_eni_assoc = {
    for k, v in data.aws_route_table.proxy_rt : v.id => {
      # TODO: eni of same subnet assoc if possible otherwise the first eni_id in lb_eni_details
      eni = local.lb_eni_details[0].eni_id
    }
  }


}