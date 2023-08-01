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

variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in resource descriptions"
}

variable "env_tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

  default = null
}

variable "agent_source_tag" {
  type        = map(any)
  description = "Tag to identify deployment source"

  default = { agent_source = "tf-cdp-module" }
}

variable "vpc_attachments" {

  type = any

  default = {}

  # example
  #   vpc1 = {
  #     vpc_id = 
  #     subnet_ids = 
  #     create_tgw_route_table
  #   },
  #   vpc 2 = {
  #     vpc_id = 
  #     subnet_ids =
  #   }

  description = "Map of map of VPC details to attach to the Transit Gateway. Type any to avoid validation on map key but should at least contain the vpc id and subnet id for the TGW attachment."
}
