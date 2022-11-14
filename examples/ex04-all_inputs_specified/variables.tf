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
variable "profile" {
  type        = string
  description = "Profile for AWS cloud credentials"

  # Profile is default unless explicitly specified
  default = "default"
}

variable "region" {
  type        = string
  description = "Region which Cloud resources will be created"
}

variable "env_tags" {
  type        = map(any)
  description = "Tags applied to provised resources"
}

variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in resource descriptions"
}

variable "public_keypair" {
  type = string

  description = "Name of the Public SSH key for the CDP environment"

}

# ------- CDP Environment Deployment -------
variable "deployment_type" {
  type = string

}

variable "deploy_cdp" {
  type = bool

  description = "Deploy the CDP environment as part of Terraform"

}

# ------- Network Resources -------
variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"
}

variable "igw_name" {
  type        = string
  description = "Internet Gateway"
}

# Public Network infrastructure
variable "public_subnets" {
  type = list(object({
    name = string
    cidr = string
    az   = string
    tags = map(string)
  }))

  description = "List of Public Subnets"
}

variable "public_route_table_name" {
  type        = string
  description = "Public Route Table Name"
}

# Private Network infrastructure
variable "private_subnets" {
  type = list(object({
    name = string
    cidr = string
    az   = string
    tags = map(string)
  }))

  description = "List of Private Subnets"
}

variable "nat_gateway_name" {
  type = string

  description = "Nat Gateway"
}

variable "private_route_table_name" {
  type = string

  description = "Private Route Table"
}

variable "security_group_default_name" {
  type = string

  description = "Default Security Group for CDP environment"
}

variable "security_group_knox_name" {
  type = string

  description = "Knox Security Group for CDP environment"
}

variable "ingress_extra_cidrs_and_ports" {
  type = object({
    cidrs = list(string)
    ports = list(number)
  })
  description = "List of extra CIDR blocks and ports to include in Security Group Ingress rules"
}

# ------- Storage Resources -------
variable "random_id_for_bucket" {
  type = bool

}

variable "data_storage" {
  type = object({
    data_storage_bucket  = string
    data_storage_objects = list(string)
  })

  description = "Storage locations for CDP environment"

}

variable "log_storage" {
  type = object({
    log_storage_bucket  = string
    log_storage_objects = list(string)
  })

  description = "Optional log locations for CDP environment. If not provided follow the data_storage variable"

}

# ------- Policies -------
# Cross Account Policy (name and document)
variable "xaccount_policy_name" {
  type        = string
  description = "Cross Account Policy name"

}

variable "xaccount_account_policy_doc" {
  type        = string
  description = "Location of cross acount policy document"

}
# CDP IDBroker Assume Role policy
variable "idbroker_policy_name" {
  type        = string
  description = "IDBroker Policy name"

}

# CDP Data Access Policies - Log
variable "log_data_access_policy_name" {
  type        = string
  description = "Log Data Access Policy Name"

}

variable "log_data_access_policy_doc_location" {
  type        = string
  description = "Location of Log Data Access Policy file."

}

# CDP Data Access Policies - ranger_audit_s3
variable "ranger_audit_s3_policy_name" {
  type        = string
  description = "Ranger S3 Audit Data Access Policy Name"

}

variable "ranger_audit_s3_policy_doc_location" {
  type        = string
  description = "Location of Ranger S3 Audit Data Access Policy file."

}

# CDP Data Access Policies - datalake_admin_s3 
variable "datalake_admin_s3_policy_name" {
  type        = string
  description = "Datalake Admin S3 Data Access Policy Name"

}

variable "datalake_admin_s3_policy_doc_location" {
  type        = string
  description = "Location of Datalake Admin S3 Data Access Policy file."

}

# CDP Data Access Policies - bucket_access
variable "bucket_access_policy_name" {
  type        = string
  description = "Bucket Access Data Access Policy Name"

}

variable "bucket_access_policy_doc_location" {
  type        = string
  description = "Location of Bucket Access Data Access Policy file."

}

# ------- Roles -------
# Cross Account Role (name and id)
variable "xaccount_role_name" {
  type        = string
  description = "Cross account Assume role Name"
}

variable "xaccount_account_id" {
  type        = string
  description = "Account ID of the cross account"
}

variable "xaccount_external_id" {
  type        = string
  description = "External ID of the cross account"
}

# IDBroker service role
variable "idbroker_role_name" {
  type        = string
  description = "IDBroker service role Name"
}

# Log service role
variable "log_role_name" {
  type        = string
  description = "Log service role Name"
}

# CDP Datalake Admin role
variable "datalake_admin_role_name" {
  type        = string
  description = "Datalake Admin role Name"
}

# CDP Ranger Audit role
variable "ranger_audit_role_name" {
  type        = string
  description = "Ranger Audit role Name"
}
