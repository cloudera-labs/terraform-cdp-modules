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
  description = "Tags applied to provisioned resources."

  default = {}
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for where the bastion VM will run."

}

# ------- Bastion SG -------
variable "create_bastion_sg" {
  type        = bool
  description = "Flag to specify if the Security Group for the bastion should be created."

  default = true
}

variable "bastion_security_group_name" {
  type        = string
  description = "Name of bastion Security Group for CDP environment. Used only if create_bastion_sg is true."

  default = null

  validation {
    condition     = var.create_bastion_sg ? (length(var.bastion_security_group_name) < 256) : true
    error_message = "The length of bastion_security_group_name must be 256 characters or less."
  }
}

variable "bastion_security_group_id" {
  type        = string
  description = "ID for existing Security Group to be used for the bastion VM. Required when create_bastion_sg is false."

  default = null
}

variable "ingress_rules" {
  description = "List of ingress rules to create. Used only if create_bastion_sg is true."
  type = list(object({
    cidrs     = list(string)
    from_port = number
    to_port   = optional(number)
    protocol  = string
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules to create. Used only if create_bastion_sg is true."
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
variable "bastion_host_name" {
  type        = string
  description = "Name of bastion host."

  default = null
}

variable "create_eip" {
  type        = bool
  description = "Flag to specify if an Elastic IP for the bastion should be created and assigned."

  default = false
}

variable "eip_name" {
  type        = string
  description = "Name of Elastic IP."

  default = null
}

variable "enable_bastion_public_ip" {
  type        = bool
  description = "Whether to create and assign an public IP to the bastion host."

  default = null
}

variable "bastion_subnet_id" {
  type        = string
  description = "The ID of the subnet where the bastion VM will run."

}

variable "bastion_aws_ami" {
  type        = string
  description = "The AWS AMI to use for the bastion VM."

  default = null
}

variable "bastion_aws_instance_type" {
  type        = string
  description = "The EC2 instance type to use for the bastion VM."

  default = "t3.medium"
}

variable "bastion_aws_keypair_name" {
  type        = string
  description = "SSH Keypair name for the bastion VM."

}

variable "bastion_user_data" {
  type        = string
  description = "Base64-encoded user data for the bastion instance."

  default = null
}

variable "replace_on_user_data_change" {
  type        = bool
  description = "Trigger a destroy and recreate of the EC2 instance when user_data changes. Defaults to false if not set."

  default = null
}

variable "bastion_az" {
  description = "The availability zone where the bastion instance will be created."
  type        = string
  default     = null
}

variable "bastion_inst_profile" {
  description = "The IAM instance profile for the bastion instance."
  type        = string
  default     = null
}

variable "bastion_private_ip" {
  description = "The private IP address for the bastion instance"
  type        = string
  default     = null
}

variable "disable_api_termination" {
  description = "Whether to disable API termination for the bastion instance"
  type        = bool
  default     = null
}

variable "bastion_shutdown_behaviour" {
  description = "The instance initiated shutdown behavior (e.g., stop or terminate)"
  type        = string
  default     = null
}

variable "bastion_src_dest_check" {
  description = "Whether to disable source/destination checks for the bastion instance"
  type        = bool
  default     = null
}

variable "bastion_monitoring" {
  description = "Whether to enable detailed monitoring for the bastion instance"
  type        = bool
  default     = null
}

variable "bastion_tenancy" {
  description = "The tenancy option for the bastion instance (e.g., default or dedicated)"
  type        = string
  default     = null
}

variable "bastion_placement_grp" {
  description = "The placement group to associate with the bastion instance"
  type        = string
  default     = null
}

variable "bastion_cpu_options" {
  description = "The CPU options for the bastion instance (e.g., number of cores and threads per core)"
  type = object({
    core_count       = number
    threads_per_core = number
  })
  default = null
}

variable "bastion_get_password_data" {
  description = "Return the password data for the bastion instance"
  type        = bool

  default = null
}