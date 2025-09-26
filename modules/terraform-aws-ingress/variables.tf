# Copyright 2025 Cloudera, Inc. All Rights Reserved.
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

variable "default_security_group_name" {
  type = string

  description = "Default Security Group for Cloudera on cloud environment"

  default = null

  validation {
    condition     = (var.default_security_group_name == null ? true : length(var.default_security_group_name) <= 256)
    error_message = "The length of default_security_group_name must be 256 characters or less."
  }
}

variable "knox_security_group_name" {
  type = string

  description = "Knox Security Group for Cloudera on cloud environment"

  default = null

  validation {
    condition     = (var.knox_security_group_name == null ? true : length(var.knox_security_group_name) <= 256)
    error_message = "The length of knox_security_group_name must be 256 characters or less."
  }
}

variable "ingress_extra_cidrs_and_ports" {
  type = object({
    cidrs = list(string)
    ports = list(number)
  })
  description = "List of extra CIDR blocks and ports to include in Security Group Ingress rules"

  default = {
    cidrs = [],
    ports = []
  }
}

variable "ingress_vpc_cidr" {
  type = string

  description = "VPC CIDR block to include in Security Group Ingress rule"

  default = null

  validation {
    condition     = (var.ingress_vpc_cidr != null) || (var.existing_knox_security_group_name != null && var.existing_default_security_group_name != null)
    error_message = "The ingress_vpc_cidr variable is required when creating new security groups (when existing_knox_security_group_name or existing_default_security_group_name is null)."
  }
}

variable "cdp_default_sg_egress_cidrs" {
  type = list(string)

  description = "List of egress CIDR blocks for CDP Default Security Group Egress rule"

  default = ["0.0.0.0/0"]
}

variable "cdp_knox_sg_egress_cidrs" {
  type = list(string)

  description = "List of egress CIDR blocks for CDP Knox Security Group Egress rule"

  default = ["0.0.0.0/0"]
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for where the security groups will be created."
}

variable "use_prefix_list_for_ingress" {
  description = "Whether to use prefix lists for ingress rules instead of direct CIDR blocks"
  type        = bool

  default = true
}

variable "prefix_list_name" {
  type        = string
  description = "Name of the AWS Prefix List to use for the security group rules."

  default = null

  validation {
    condition     = !var.use_prefix_list_for_ingress || (var.use_prefix_list_for_ingress && var.prefix_list_name != null)
    error_message = "When use_prefix_list_for_ingress is set to true, prefix_list_name must not be null."
  }
}

variable "tags" {
  type        = map(any)
  description = "Tags applied to provisioned resources"

  default = null
}

# ------- Support for existing Security Groups -------
variable "existing_default_security_group_name" {
  type        = string
  description = "Name of existing Default Security Group for Cloudera on cloud environment. If set then no security group or ingress rules are created for the Default SG."

  default = null
}

variable "existing_knox_security_group_name" {
  type        = string
  description = "Name of existing Knox Security Group for Cloudera on cloud environment. If set then no security group or ingress rules are created for the Knox SG."

  default = null
}
