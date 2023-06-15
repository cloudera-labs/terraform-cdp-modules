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
variable "infra_type" {
  type        = string
  description = "Cloud Provider to deploy CDP."

  default = "azure"

  validation {
    condition     = contains(["azure"], var.infra_type)
    error_message = "Valid values for var: infra_type are (azure)."
  }
}

variable "azure_region" {
  type        = string
  description = "Region which Cloud resources will be created"

  default = null
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

variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in resource descriptions"
}


# ------- CDP Environment Deployment -------
variable "cdp_profile" {
  type        = string
  description = "Profile for CDP credentials"

  # Profile is default unless explicitly specified
  default = "default"
}

variable "cdp_control_plane_region" {
  type        = string
  description = "CDP Control Plane Region"

  # Region is us-west-1 unless explicitly specified
  default = "us-west-1"
}

variable "deployment_template" {
  type = string

  description = "Deployment Pattern to use for Cloud resources and CDP"

  validation {
    condition     = contains(["public", "semi-private", "private"], var.deployment_template)
    error_message = "Valid values for var: deployment_template are (public, semi-private, private)."
  }
}

# ------- Network Resources -------
variable "resourcegroup_name" {
  type        = string
  description = "Resource Group name"

  default = null
}

variable "vnet_name" {
  type        = string
  description = "VNet name"

  default = null
}

variable "vnet_cidr" {
  type        = string
  description = "VNet CIDR Block"

  default = "10.10.0.0/16"
}

variable "subnet_count" {
  type        = string
  description = "Number of Subnets Required"

  default = "3"
}

# Security Groups
variable "security_group_default_name" {
  type = string

  description = "Default Security Group for CDP environment"

  default = null
}

variable "security_group_knox_name" {
  type = string

  description = "Knox Security Group for CDP environment"

  default = null
}

variable "cdp_control_plane_cidrs" {
  type = list(string)

  description = "CIDR for access to CDP Control Plane"

  default = ["52.36.110.208/32", "52.40.165.49/32", "35.166.86.177/32"]
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

# ------- Storage Resources -------
variable "random_id_for_bucket" {
  type = bool

  description = "Create a random suffix for the Storage Account names"

  default = true

}

variable "data_storage" {
  type = object({
    data_storage_bucket = string
    data_storage_object = string
  })

  description = "Data storage locations for CDP environment"

  default = null
}

variable "log_storage" {
  type = object({
    log_storage_bucket = string
    log_storage_object = string
  })

  description = "Optional log locations for CDP environment. If not provided follow the data_storage variable"

  default = null
}

variable "backup_storage" {
  type = object({
    backup_storage_bucket = string
    backup_storage_object = string
  })

  description = "Optional Backup location for CDP environment. If not provided follow the data_storage variable"

  default = null
}
