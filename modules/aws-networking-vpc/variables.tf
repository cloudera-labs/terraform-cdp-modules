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

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"

  default = "10.11.0.0/16"
}

variable "enable_nat_gateway" {

  type = bool
  description = "Provision NAT Gateways for each of your private networks"

  default = true
  
}