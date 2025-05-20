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
variable "aws_region" {
  type        = string
  description = "Region which Cloud resources will be created"
}

variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in resource descriptions"

  validation {
    condition     = length(var.env_prefix) <= 12
    error_message = "The length of env_prefix must be 12 characters or less."
  }
  validation {
    condition     = (var.env_prefix == null ? true : can(regex("^[a-z0-9-]{1,12}$", var.env_prefix)))
    error_message = "env_prefix can consist only of lowercase letters, numbers, and hyphens (-)."
  }
}

variable "aws_key_pair" {
  type = string

  description = "Name of the Public SSH key for the CDP environment"

}

variable "env_tags" {
  type        = map(any)
  description = "Tags applied to pvovisioned resources"

  default = null
}

# ------- CDP Environment Deployment -------
variable "deployment_template" {
  type = string

  description = "Deployment Pattern to use for Cloud resources and CDP"
}

variable "environment_async_creation" {
  type = bool

  description = "Flag to specify if Terraform should wait for CDP environment resource creation/deletion"

  default = false
}

variable "datalake_async_creation" {
  type = bool

  description = "Flag to specify if Terraform should wait for CDP datalake resource creation/deletion"

  default = false
}

variable "cdp_groups" {
  type = set(object({
    name                          = string
    create_group                  = bool
    sync_membership_on_user_login = optional(bool)
    add_id_broker_mappings        = bool
    })
  )

  description = "List of CDP Groups to be added to the IDBroker mappings of the environment. If create_group is set to true then the group will be created."

  validation {
    condition = (var.cdp_groups == null ? true : alltrue([
      for grp in var.cdp_groups :
      length(grp.name) >= 1 && length(grp.name) <= 64
    ]))
    error_message = "The length of all CDP group names must be 64 characters or less."
  }
  validation {
    condition = (var.cdp_groups == null ? true : alltrue([
      for grp in var.cdp_groups :
      can(regex("^[a-zA-Z0-9\\-\\_\\.]{1,90}$", grp.name))
    ]))
    error_message = "CDP group names can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
  }

  default = null
}
variable "compute_cluster_enabled" {
  type = bool

  description = "Enable externalized compute cluster for the environment"

  default = false
}

variable "compute_cluster_configuration" {
  type = map(object({
    kube_api_authorized_ip_ranges = optional(set(string))
    private_cluster               = optional(bool)
    worker_node_subnets           = optional(set(string))
  }))

  description = "Kubernetes configuration for the externalized compute cluster"

  default = null
}

# ------- Network Resources -------
variable "ingress_extra_cidrs_and_ports" {
  type = object({
    cidrs = list(string)
    ports = list(number)
  })
  description = "List of extra CIDR blocks and ports to include in Security Group Ingress rules"
}

# ------- Optional inputs for BYO-VPC -------
variable "create_vpc" {
  type = bool

  description = "Flag to specify if the VPC should be created"

  default = true
}

variable "cdp_vpc_id" {
  type        = string
  description = "VPC ID for CDP environment. Required if create_vpc is false."

  default = null
}

variable "cdp_public_subnet_ids" {
  type        = list(any)
  description = "List of public subnet ids. Required if create_vpc is false."

  default = null
}

variable "cdp_private_subnet_ids" {
  type        = list(any)
  description = "List of private subnet ids. Required if create_vpc is false."

  default = null
}

# ------- Optional inputs for Control Plane Connectivity in fully private environment -------
variable "private_network_extensions" {
  type = bool

  description = "Enable creation of resources for connectivity to CDP Control Plane (public subnet and NAT Gateway) for Private Deployment. Only relevant for private deployment template"

  default = true
}