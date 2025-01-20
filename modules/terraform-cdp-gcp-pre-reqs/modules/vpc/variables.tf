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

variable "vpc_name" {
  type        = string
  description = "VPC Network name"

}

variable "vpc_cidr" {
  type        = string
  description = "VPC Network CIDR Block"

}

variable "subnet_count" {
  type        = number
  description = "Number of Subnets Required"

}

variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in resource descriptions"
}

variable "cdp_subnet_private_ip_google_access" {
  type        = bool
  description = "Flag to enable VMs in CDP subnets to access Google APIs and services by using Private Google Access"
}