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

  default = "aws"

  validation {
    condition     = contains(["aws"], var.infra_type)
    error_message = "Valid values for var: infra_type are (aws)."
  }
}

variable "aws_region" {
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

variable "lookup_cdp_account_ids" {
  type = bool

  description = "Auto lookup CDP Account and External ID using CDP CLI commands. If false then the xaccount_account_id and xaccount_external_id input variables need to be specified"

  default = true
}

# variable "enable_raz" {
#   type = bool

#   description = "Flag to enable Ranger Authorization Service (RAZ)"

#   default = true
# }

# ------- Network Resources -------
variable "create_vpc" {
  type = bool

  description = "Flag to specify if the VPC should be created"

  default = true
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"

  default = "10.10.0.0/16"
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

# ------- Storage Resources -------
variable "random_id_for_bucket" {
  type = bool

  description = "Create a random suffix for the bucket names"

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

# ------- Policies -------
# Cross Account Policy (name and document)
variable "xaccount_policy_name" {
  type        = string
  description = "Cross Account Policy name"

  default = null
}

variable "xaccount_account_policy_doc" {
  type        = string
  description = "Location of cross acount policy document"

  default = null
}

# CDP IDBroker Assume Role policy
variable "idbroker_policy_name" {
  type        = string
  description = "IDBroker Policy name"

  default = null
}

# CDP Data Access Policies - Log
variable "log_data_access_policy_name" {
  type        = string
  description = "Log Data Access Policy Name"

  default = null
}

variable "log_data_access_policy_doc" {
  type        = string
  description = "Location or Contents of Log Data Access Policy"

  default = null
}

# CDP Data Access Policies - ranger_audit_s3
variable "ranger_audit_s3_policy_name" {
  type        = string
  description = "Ranger S3 Audit Data Access Policy Name"

  default = null
}

variable "ranger_audit_s3_policy_doc" {
  type        = string
  description = "Location or Contents of Ranger S3 Audit Data Access Policy"

  default = null
}

# CDP Data Access Policies - datalake_admin_s3 
variable "datalake_admin_s3_policy_name" {
  type        = string
  description = "Datalake Admin S3 Data Access Policy Name"

  default = null
}

variable "datalake_admin_s3_policy_doc" {
  type        = string
  description = "Location or Contents of Datalake Admin S3 Data Access Policy"

  default = null
}

variable "datalake_backup_policy_doc" {
  type        = string
  description = "Location of Datalake Backup Data Access Policy"

  default = null
}

variable "datalake_restore_policy_doc" {
  type        = string
  description = "Location of Datalake Restore Data Access Policy"

  default = null
}

# CDP Data Access Policies - bucket_access
variable "bucket_access_policy_name" {
  type        = string
  description = "Bucket Access Data Access Policy Name"

  default = null
}

# CDP Datalake restore Policies - datalake
variable "datalake_restore_policy_name" {
  type        = string
  description = "Datalake restore Data Access Policy Name"

  default = null
}

# CDP Datalake backup Policies - datalake
variable "datalake_backup_policy_name" {
  type        = string
  description = "Datalake backup Data Access Policy Name"

  default = null
}

variable "bucket_access_policy_doc" {
  type        = string
  description = "Bucket Access Data Access Policy"

  default = null
}

# ------- Roles -------
# Cross Account Role (name and id)
variable "xaccount_role_name" {
  type        = string
  description = "Cross account Assume role Name"

  default = null
}

variable "xaccount_account_id" {
  type        = string
  description = "Account ID of the cross account"

  default = null
}

variable "xaccount_external_id" {
  type        = string
  description = "External ID of the cross account"

  default = null
}

# IDBroker service role
variable "idbroker_role_name" {
  type        = string
  description = "IDBroker service role Name"

  default = null
}

# Log service role
variable "log_role_name" {
  type        = string
  description = "Log service role Name"

  default = null
}

# CDP Datalake Admin role
variable "datalake_admin_role_name" {
  type        = string
  description = "Datalake Admin role Name"

  default = null
}

# CDP Ranger Audit role
variable "ranger_audit_role_name" {
  type        = string
  description = "Ranger Audit role Name"

  default = null
}
