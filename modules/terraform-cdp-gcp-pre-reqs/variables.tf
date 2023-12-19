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
variable "gcp_region" {
  type        = string
  description = "Region which Cloud resources will be created"

  default = null
}

variable "env_tags" {
  type        = map(any)
  description = "Tags applied to provisioned resources"

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
variable "deployment_template" {
  type = string

  description = "Deployment Pattern to use for Cloud resources and CDP"

  validation {
    condition     = contains(["public", "semi-private", "private"], var.deployment_template)
    error_message = "Valid values for var: deployment_template are (public, semi-private, private)."
  }
}

variable "enable_raz" {
  type = bool

  description = "Flag to enable Ranger Authorization Service (RAZ)"

  default = true
}

# ------- Network Resources -------
variable "create_vpc" {
  type = bool

  description = "Flag to specify if the VPC Network should be created"

  default = true
}

variable "vpc_name" {
  type        = string
  description = "VPC name"

  default = null
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"

  default = "10.1.0.0/19"
}

variable "cdp_vpc_name" {
  type        = string
  description = "VPC Name for CDP environment. Required if create_vpc is false."

  default = null
}

variable "cdp_subnet_names" {
  type        = list(any)
  description = "List of subnet names. Required if create_vpc is false."

  default = null
}

variable "subnet_count" {
  type        = number
  description = "Number of Subnets Required"

  default = 1
}

# VPC Peering settings for Managed Service Network Connection for CloudSQL  
variable "managed_services_global_address_name" {
  type = string

  description = "Name of the Managed Service address used for the Peering Connection to CloudSQL"

  default = null
}

variable "managed_services_global_address_cidr" {
  type = string

  description = "CIDR Block for Google Managed Service VPC Peering Connection Address"

  default = "10.10.192.0/24"

}
# Firewall
variable "firewall_internal_name" {
  type = string

  description = "Name of Firewall for Internal Virtual Network communication"

  default = null
}

variable "firewall_default_name" {
  type = string

  description = "Name of Default Firewall for CDP environment"

  default = null
}

variable "firewall_knox_name" {
  type = string

  description = "Name of Knox Firewall for CDP environment"

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

variable "compute_router_name" {
  type        = string
  description = "Name of the Google Compute Router resource created for private deployment."

  default = null

}

variable "compute_router_bgp_settings" {
  type = object({
    asn                  = number
    advertise_mode       = optional(string)
    advertised_groups    = optional(string)
    advertised_ip_ranges = optional(list(object({})))
    keepalive_interval   = optional(number)
  })

  description = "BGP settings used for the Google Compute Router resource in private deployments."

  default = {
    asn            = 64514
    advertise_mode = "DEFAULT"
  }
}

variable "compute_router_nat_name" {
  type        = string
  description = "Name of the Google Compute Router NAT created for private deployment."

  default = null

}

variable "compute_router_nat_ip_allocate_option" {
  type        = string
  description = "How external IPs should be allocated for Google Compute Router NAT in private deployments."

  default = "AUTO_ONLY"
}

variable "compute_router_nat_source_subnetwork_ip_ranges" {
  type        = string
  description = "How NAT should be configured per Subnetwork for Google Compute Router NAT in private deployments."

  default = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}


# ------- Storage Resources -------
variable "random_id_for_bucket" {
  type = bool

  description = "Create a random suffix for the bucket names"

  default = true

}

variable "bucket_storage_region" {
  type = string

  description = "The location of the Google Cloud Storage buckets for data, backups and logs. By default this follows the gcp_region variable."

  default = null
}

# variable "data_storage" {
#   type = object({
#     data_storage_bucket = string
#     data_storage_object = string
#   })

#   description = "Data storage locations for CDP environment"

#   default = null
# }

# variable "log_storage" {
#   type = object({
#     log_storage_bucket = string
#     log_storage_object = string
#   })

#   description = "Optional log locations for CDP environment. If not provided follow the data_storage variable"

#   default = null
# }

# variable "backup_storage" {
#   type = object({
#     backup_storage_bucket = string
#     backup_storage_object = string
#   })

#   description = "Optional Backup location for CDP environment. If not provided follow the data_storage variable"

#   default = null
# }

variable "data_storage_bucket" {
  type = string

  description = "Data storage locations for CDP environment"

  default = null
}

variable "log_storage_bucket" {
  type = string

  description = "Optional log locations for CDP environment."

  default = null
}

variable "backup_storage_bucket" {
  type        = string
  description = "Optional Backup location for CDP environment."

  default = null
}

variable "bucket_storage_class" {

  type = string

  description = "The GCS storage class to use for the data, log and backup storage"

  default = "NEARLINE"

}

# ------- Authz Resources -------
# Cross Account Service Account
variable "xaccount_service_account_name" {
  type = string

  description = "Cross Account service account name"

  default = null
}

# Role Assignments to cross account
variable "xaccount_sa_policies" {
  type = list(string)

  description = "List of IAM policies to apply to the Cross Account Service Account"

  default = [
    "roles/compute.instanceAdmin.v1",
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin",
    "roles/compute.imageUser",
    "roles/compute.storageAdmin",
    "roles/runtimeconfig.admin",
    "roles/cloudkms.admin",
    "roles/owner"
  ]

}

# Custom Roles
# ...Log data access role
variable "log_data_access_custom_role_name" {
  type = string

  description = "Name of Log Data Access Custom Role"

  default = null

}

# ...Ranger Audit and Datalake Admin Role
variable "datalake_admin_custom_role_name" {
  type = string

  description = "Name of Ranger Audit and Datalake Admin Custom Role"

  default = null

}

# ...IDBroker Role
variable "idbroker_custom_role_name" {
  type = string

  description = "Name of IDBroker Custom Role"

  default = null

}

# Operational Service Accounts
variable "log_service_account_name" {
  type = string

  description = "Log service account name"

  default = null
}

variable "datalake_admin_service_account_name" {
  type = string

  description = "Datalake Admin service account name"

  default = null
}

variable "ranger_audit_service_account_name" {
  type = string

  description = "Ranger Audit service account name"

  default = null
}

variable "idbroker_service_account_name" {
  type = string

  description = "IDBroker service account name"

  default = null
}

# Permission Assignments to Custom Roles
variable "log_role_permissions" {
  type = list(string)

  description = "List of Permission Assignments to the Log Data Access Custom Role"

  default = [
    "storage.buckets.get",
    "storage.objects.create"
  ]

}

variable "datalake_admin_role_permissions" {
  type = list(string)

  description = "List of Permission Assignments to the Ranger Audit and Datalake Admin Custom Role"

  default = [
    "storage.buckets.get",
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.get",
    "storage.objects.list"
  ]

}

variable "idbroker_role_permissions" {
  type = list(string)

  description = "List of Permission Assignments to the IDBroker Custom Role"

  default = [
    "iam.serviceAccounts.getAccessToken",
    "iam.serviceAccounts.actAs"
  ]

}
