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
variable "env_tags" {
  type        = map(any)
  description = "Tags applied to provisioned resources"

  default = {}
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for where the bastion VM will run"

}

# ------- Bastion SG -------
variable "create_bastion_sg" {
  type = bool

  description = "Flag to specify if the Security Group for the bastion should be created."

  default = true
}

variable "bastion_security_group_name" {
  type = string

  description = "Name of Bastion Security Group for CDP environment. Used only if create_bastion_sg is true."

  default = null

  validation {
    condition     = var.create_bastion_sg ? (length(var.bastion_security_group_name) < 256) : true
    error_message = "The length of bastion_security_group_name must be 256 characters or less."
  }
}

variable "bastion_security_group_id" {
  type = string

  description = "ID for existing Security Group to be used for the bastion VM. Required when create_bastion_sg is false"

  default = null
}

variable "ingress_rules" {
  description = "List of ingress rules to create. Used only if create_bastion_sg is true"
  type = list(object({
    cidrs     = list(string)
    from_port = number
    to_port   = optional(number)
    protocol  = string
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules to create. Used only if create_bastion_sg is true"
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

# ------- Bastion Settings -------
variable "bastion_port" {
  type        = number
  description = "Port number which the bastion listens"

  default = 3129
}

variable "create_eip" {
  type        = bool
  description = "Whether to create and assign an Elastic IP to the Bastion host"
  
  default     = true
}

variable "bastion_aws_ami" {
  type        = string
  description = "The AWS AMI to use for the bastion VM"

  default = null
}

variable "bastion_aws_instance_type" {
  type        = string
  description = "The EC2 instance type to use for the bastion VM"

  default = "t3.medium"

}

variable "bastion_aws_keypair_name" {
  type = string

  description = "SSH Keypair name for the bastion VM"

}

variable "bastion_subnet_id" {
  type = string

  description = "The ID of the subnet where the bastion VM will run"

}

variable "bastion_cloud_init_file" {
  type = string

  description = "Location of the Bastion cloud-init file. If not specified, the files/cloud-init.yaml file accompanying the module is used."

  default = null
}