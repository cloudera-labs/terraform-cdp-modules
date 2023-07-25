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

  env_tags = merge(var.agent_source_tag, (
    coalesce(var.env_tags,
      { env_prefix = var.env_prefix }
    ))
  )

  # Create local for transit gateway route table entries
  vpc_attachment_with_tgw_routes = flatten([
    for attach, attach_value in var.vpc_attachments :
    [
      for route in attach_value.tgw_routes :
      {
        create_tgw_route_table = attach_value.create_tgw_route_table
        route_table_key        = attach
        route_attachement_key  = route.route_attachment_key
        destination_cidr_block = route.destination_cidr_block
      }
    ]
    if can(attach_value.tgw_routes)
  ])
 
 vpc_attachment_with_vpc_routes = flatten([
    for attach, attach_value in var.vpc_attachments :
    [
      for route in try(attach_value.vpc_routes, []) :
      [
      for rt in try(route.route_tables, []) :
      {
        create_vpc_routes  = attach_value.create_vpc_routes
        route_table        = rt
        attachement_key     = attach
        destination_cidr_block = route.destination_cidr_block
      }
      ]
    ]
    if (can(attach_value.vpc_routes) && try(attach_value.create_vpc_routes,false))
  ])

}