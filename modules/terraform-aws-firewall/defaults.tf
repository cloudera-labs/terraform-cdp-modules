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

  # Local variables to determine route table to Firewall VPC Endpoint mapping
  route_tables_to_update = flatten([
    for route in var.route_tables_to_update :
    [
      for rti, rt in route.route_tables :
      {
        route_table            = rt
        availability_zone      = try(route.availability_zones[rti], null)
        destination_cidr_block = route.destination_cidr_block
      }
    ]
  ])

}