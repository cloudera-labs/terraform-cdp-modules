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

# ------- Global settings -------
variable "aws_region" {
  type        = string
  description = "Region which Cloud resources will be created"
}

variable "env_tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

  default = null
}

variable "name_prefix" {
  type        = string
  description = "Shorthand name to use when naming resources."
}

variable "cdp_vpc_private_cidr_range" {
  type        = number
  description = "Size of each private subnet for CDP VPC."

  default = 19
}

variable "cdp_vpc_public_cidr_range" {
  type        = number
  description = "Size of each public subnet for CDP VPC."

  default = 24
}

variable "network_vpc_private_cidr_range" {
  type        = number
  description = "Size of each private subnet for Network VPC."

  default = 19
}

variable "network_vpc_public_cidr_range" {
  type        = number
  description = "Size of each public subnet for Network VPC."

  default = 24
}