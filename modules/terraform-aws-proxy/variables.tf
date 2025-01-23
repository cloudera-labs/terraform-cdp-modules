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

# ------- Global settings -------
variable "env_tags" {
  type        = map(any)
  description = "Tags applied to provisioned resources"

  default = {}
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for where the proxy VM will run"

}

variable "cdp_region" {
  type        = string
  description = "CDP Control Plane region, used in Proxy Whitelist configuration files."

  default = "us-west-1"
}

variable "aws_region" {
  type        = string
  description = "AWS region, used in Proxy Whitelist configuration files. If not provided will perform lookup of aws_region data source."

  default = null
}

# ------- Proxy SG -------
variable "create_proxy_sg" {
  type = bool

  description = "Flag to specify if the Security Group for the proxy should be created."

  default = true
}

variable "proxy_security_group_name" {
  type = string

  description = "Name of Proxy Security Group for CDP environment. Used only if create_proxy_sg is true."

  default = null

  validation {
    condition     = length(var.proxy_security_group_name) <= 256
    error_message = "The length of proxy_security_group_name must be 256 characters or less."
  }
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

# ------- Proxy Settings -------
variable "proxy_port" {
  type        = number
  description = "Port number which the proxy and NLB listens"

  default = 3129
}

variable "proxy_launch_template_name" {
  type = string

  description = "Name of Launch Template for the Proxy VMs."

  validation {
    condition     = length(var.proxy_launch_template_name) <= 255
    error_message = "The length of proxy_launch_template_name must be 255 characters or less."
  }

}

variable "enable_proxy_public_ip" {
  type = bool

  description = "Assign a public IP address to the Proxy VM"

  default = true
}

variable "proxy_aws_ami" {
  type        = string
  description = "The AWS AMI to use for the proxy VM"

  default = null
}

variable "proxy_aws_instance_type" {
  type        = string
  description = "The EC2 instance type to use for the proxy VM"

  default = "t3.medium"

}

variable "proxy_aws_keypair_name" {
  type = string

  description = "SSH Keypair name for the proxy VM"

}

variable "proxy_launch_template_user_data_file" {
  type = string

  description = "Location of the AWS Launch Template user data script. If not specified the files/user-data-proxy.sh.tpl file accompanying the module is used."

  default = null
}

variable "proxy_whitelist_file" {
  type = string

  description = "Location of the Proxy Whitelist file. If not specified the files/squid-http-whitelist.txt.tpl file accompanying the module is used."

  default = null
}

variable "proxy_autoscaling_group_name" {
  type = string

  description = "Name of Autoscaling Group for the Proxy VMs."

  validation {
    condition     = length(var.proxy_autoscaling_group_name) <= 255
    error_message = "The length of proxy_autoscaling_group_name must be 255 characters or less."
  }

}

variable "autoscaling_group_scaling" {
  type = object({
    min_size         = number
    max_size         = number
    desired_capacity = number
  })

  description = "Minimum, maximum and desired size of EC2 instance in the Auto Scaling Group."

  default = {
    min_size         = 3
    max_size         = 6
    desired_capacity = 3
  }
}

variable "proxy_subnet_ids" {
  type = list(any)

  description = "The IDs of the subnet where the proxy VMs will run"

}

# ------- Internal Network Load Balancer -------
variable "network_load_balancer_name" {
  type = string

  description = "Name of Network Load Balancer for the Proxy."

  validation {
    condition     = length(var.network_load_balancer_name) <= 32
    error_message = "The length of network_load_balancer_name must be 32 characters or less."
  }

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,32}$", var.network_load_balancer_name))
    error_message = "Network Load Balancer names can consist only of letters, numbers, and hyphens (-)."
  }
}

variable "lb_subnet_ids" {
  type = list(any)

  description = "The IDs of the subnet for the Network Load Balancer"

}

variable "target_group_proxy_name" {
  type = string

  description = "Name of Target Group for the Proxy."

  validation {
    condition     = length(var.target_group_proxy_name) <= 32
    error_message = "The length of target_group_proxy_name must be 32 characters or less."
  }

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,32}$", var.target_group_proxy_name))
    error_message = "Target Group names can consist only of letters, numbers, and hyphens (-)."
  }
}

# ------- Route table updates -------
variable "route_tables_to_update" {
  description = "List of any route tables to update to point to the Network interface of the Proxy VM"
  type = list(object({
    route_tables           = list(string)
    availability_zones     = optional(list(string))
    destination_cidr_block = string
  }))

  default = []
}
