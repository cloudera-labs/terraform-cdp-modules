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

variable "aws_instance_type" {
  type        = string
  description = "The EC2 instance type to use for the proxy VM"

  default = "t2.micro"

}

variable "aws_ami" {
  type        = string
  description = "The AWS AMI to use for the proxy VM"

  default = null
}

variable "aws_keypair_name" {
  type = string

  description = "SSH Keypair name for the proxy VM"

}

variable "vpc_id" {
  type        = string
  description = "VPC ID for where the proxy VM will run"

}

variable "subnet_id" {
  type = string

  description = "The ID of the subnet where the proxy VM will run"

}

variable "proxy_public_ip" {
  type = bool

  description = "Assign a public IP address to the Proxy VM"

  default = false
}

variable "create_proxy_sg" {
  type = bool

  description = "Flag to specify if the Security Group for the proxy should be created."

  default = true
}

variable "security_group_proxy_name" {
  type = string

  description = "Name of Proxy Security Group for CDP environment. Used only if create_proxy_sg is true."

  default = null
}

variable "proxy_security_group_id" {
  type = string

  description = "ID for existing Security Group to be used for the proxy VM. Required when create_proxy_sg is false"

  default = null
}

variable "ingress_rules" {
  description = "List of ingress rules to create. Used only if create_proxy_sg is true"
  type = list(object({
    cidrs     = list(string)
    from_port = number
    to_port   = optional(number)
    protocol  = string
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules to create. Used only if create_proxy_sg is true"
  type = list(object({
    cidrs     = list(string)
    from_port = number
    to_port   = optional(number)
    protocol  = string
  }))
  default = [{
    cidrs     = ["0.0.0.0/0"]
    from_port = 0
    to_port   = 0
    protocol  = "all"
  }]
}

variable "route_tables_to_update" {
  description = "List of any route tables to update to point to the Network interface of the Proxy VM"
  type = list(object({
    route_tables           = list(string)
    destination_cidr_block = string
  }))
}
