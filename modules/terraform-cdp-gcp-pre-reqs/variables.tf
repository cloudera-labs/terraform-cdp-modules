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

# TODO: Explore how to enable tagging of resources
# variable "env_tags" {
#   type        = map(any)
#   description = "Tags applied to provisioned resources"

#   default = null
# }

# variable "agent_source_tag" {
#   type        = map(any)
#   description = "Tag to identify deployment source"

#   default = { agent_source = "tf-cdp-module" }
# }

variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in resource descriptions"

  validation {
    condition     = length(var.env_prefix) <= 16
    error_message = "The length of env_prefix must be 16 characters or less."
  }
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

  validation {
    condition     = (var.vpc_name == null ? true : length(var.vpc_name) >= 1 && length(var.vpc_name) <= 63)
    error_message = "The length of vpc_name must be 63 characters or less."
  }

  validation {
    condition     = (var.vpc_name == null ? true : can(regex("^[a-z0-9\\-]{1,63}$", var.vpc_name)))
    error_message = "vpc_name can consist only of lowercase letters, numbers and hyphens (-)."
  }

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

  validation {
    condition     = (var.managed_services_global_address_name == null ? true : length(var.managed_services_global_address_name) >= 1 && length(var.managed_services_global_address_name) <= 63)
    error_message = "The length of managed_services_global_address_name must be 63 characters or less."
  }

  validation {
    condition     = (var.managed_services_global_address_name == null ? true : can(regex("^[a-z0-9\\-]{1,63}$", var.managed_services_global_address_name)))
    error_message = "managed_services_global_address_name can consist only of lowercase letters, numbers and hyphens (-)."
  }
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

  validation {
    condition     = (var.firewall_internal_name == null ? true : length(var.firewall_internal_name) >= 1 && length(var.firewall_internal_name) <= 63)
    error_message = "The length of firewall_internal_name must be 63 characters or less."
  }

  validation {
    condition     = (var.firewall_internal_name == null ? true : can(regex("^[a-z0-9\\-]{1,63}$", var.firewall_internal_name)))
    error_message = "firewall_internal_name can consist only of lowercase letters, numbers and hyphens (-)."
  }
}

variable "firewall_default_name" {
  type = string

  description = "Name of Default Firewall for CDP environment"

  default = null

  validation {
    condition     = (var.firewall_default_name == null ? true : length(var.firewall_default_name) >= 1 && length(var.firewall_default_name) <= 63)
    error_message = "The length of firewall_default_name must be 63 characters or less."
  }

  validation {
    condition     = (var.firewall_default_name == null ? true : can(regex("^[a-z0-9\\-]{1,63}$", var.firewall_default_name)))
    error_message = "firewall_default_name can consist only of lowercase letters, numbers and hyphens (-)."
  }
}

variable "firewall_knox_name" {
  type = string

  description = "Name of Knox Firewall for CDP environment"

  default = null

  validation {
    condition     = (var.firewall_knox_name == null ? true : length(var.firewall_knox_name) >= 1 && length(var.firewall_knox_name) <= 63)
    error_message = "The length of firewall_knox_name must be 63 characters or less."
  }

  validation {
    condition     = (var.firewall_knox_name == null ? true : can(regex("^[a-z0-9\\-]{1,63}$", var.firewall_knox_name)))
    error_message = "firewall_knox_name can consist only of lowercase letters, numbers and hyphens (-)."
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

variable "compute_router_name" {
  type        = string
  description = "Name of the Google Compute Router resource created for private deployment."

  default = null

  validation {
    condition     = (var.compute_router_name == null ? true : length(var.compute_router_name) >= 1 && length(var.compute_router_name) <= 63)
    error_message = "The length of compute_router_name must be 63 characters or less."
  }

  validation {
    condition     = (var.compute_router_name == null ? true : can(regex("^[a-z0-9\\-]{1,63}$", var.compute_router_name)))
    error_message = "compute_router_name can consist only of lowercase letters, numbers and hyphens (-)."
  }

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

  validation {
    condition     = (var.compute_router_nat_name == null ? true : length(var.compute_router_nat_name) >= 1 && length(var.compute_router_nat_name) <= 63)
    error_message = "The length of compute_router_nat_name must be 63 characters or less."
  }

  validation {
    condition     = (var.compute_router_nat_name == null ? true : can(regex("^[a-z0-9\\-]{1,63}$", var.compute_router_nat_name)))
    error_message = "compute_router_nat_name can consist only of lowercase letters, numbers and hyphens (-)."
  }
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

  validation {
    condition     = (var.data_storage_bucket == null ? true : (length(var.data_storage_bucket) >= 3 && length(var.data_storage_bucket) <= 63))
    error_message = "The length of data_storage_bucket must be between 3 and 63 characters."
  }

  validation {
    condition     = (var.data_storage_bucket == null ? true : (can(regex("^[a-z0-9\\-\\_\\.]{3,63}$", var.data_storage_bucket))))
    error_message = "data_storage_bucket can consist only of lowercase letters and numbers, dots (.), hyphens (-) and underscores (_)."
  }

}

variable "log_storage_bucket" {
  type = string

  description = "Optional log locations for CDP environment."

  default = null

  validation {
    condition     = (var.log_storage_bucket == null ? true : (length(var.log_storage_bucket) >= 3 && length(var.log_storage_bucket) <= 63))
    error_message = "The length of log_storage_bucket must be between 3 and 63 characters."
  }

  validation {
    condition     = (var.log_storage_bucket == null ? true : (can(regex("^[a-z0-9\\-\\_\\.]{3,63}$", var.log_storage_bucket))))
    error_message = "log_storage_bucket can consist only of lowercase letters and numbers, dots (.), hyphens (-) and underscores (_)."
  }
}

variable "backup_storage_bucket" {
  type        = string
  description = "Optional Backup location for CDP environment."

  default = null

  validation {
    condition     = (var.backup_storage_bucket == null ? true : (length(var.backup_storage_bucket) >= 3 && length(var.backup_storage_bucket) <= 63))
    error_message = "The length of backup_storage_bucket must be between 3 and 63 characters."
  }

  validation {
    condition     = (var.backup_storage_bucket == null ? true : (can(regex("^[a-z0-9\\-\\_\\.]{3,63}$", var.backup_storage_bucket))))
    error_message = "backup_storage_bucket can consist only of lowercase letters and numbers, dots (.), hyphens (-) and underscores (_)."
  }
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

  validation {
    condition     = (var.xaccount_service_account_name == null ? true : length(var.xaccount_service_account_name) >= 6 && length(var.xaccount_service_account_name) <= 30)
    error_message = "The length of xaccount_service_account_name must be between 6 and 30 characters."
  }

  validation {
    condition     = (var.xaccount_service_account_name == null ? true : can(regex("^[a-z0-9\\-]{6,30}$", var.xaccount_service_account_name)))
    error_message = "xaccount_service_account_name can consist only of lowercase letters, numbers and hyphens (-)."
  }
}

# Role Assignments to cross account
variable "xaccount_sa_policies" {
  type = list(string)

  description = "List of IAM policies to apply to the Cross Account Service Account"

  default = [
    "roles/iam.serviceAccountUser",
    "roles/compute.instanceAdmin.v1",
    "roles/storage.admin",
    "roles/compute.networkViewer",
    "roles/compute.loadBalancerAdmin",
    "roles/cloudsql.admin",
    "roles/compute.networkUser",
    "roles/compute.publicIpAdmin",
    "roles/cloudkms.admin"
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

  validation {
    condition     = (var.log_service_account_name == null ? true : length(var.log_service_account_name) >= 6 && length(var.log_service_account_name) <= 30)
    error_message = "The length of log_service_account_name must be between 6 and 30 characters."
  }

  validation {
    condition     = (var.log_service_account_name == null ? true : can(regex("^[a-z0-9\\-]{6,30}$", var.log_service_account_name)))
    error_message = "log_service_account_name can consist only of lowercase letters, numbers and hyphens (-)."
  }
}

variable "datalake_admin_service_account_name" {
  type = string

  description = "Datalake Admin service account name"

  default = null

  validation {
    condition     = (var.datalake_admin_service_account_name == null ? true : length(var.datalake_admin_service_account_name) >= 6 && length(var.datalake_admin_service_account_name) <= 30)
    error_message = "The length of datalake_admin_service_account_name must be between 6 and 30 characters."
  }

  validation {
    condition     = (var.datalake_admin_service_account_name == null ? true : can(regex("^[a-z0-9\\-]{6,30}$", var.datalake_admin_service_account_name)))
    error_message = "datalake_admin_service_account_name can consist only of lowercase letters, numbers and hyphens (-)."
  }
}

variable "ranger_audit_service_account_name" {
  type = string

  description = "Ranger Audit service account name"

  default = null

  validation {
    condition     = (var.ranger_audit_service_account_name == null ? true : length(var.ranger_audit_service_account_name) >= 6 && length(var.ranger_audit_service_account_name) <= 30)
    error_message = "The length of ranger_audit_service_account_name must be between 6 and 30 characters."
  }

  validation {
    condition     = (var.ranger_audit_service_account_name == null ? true : can(regex("^[a-z0-9\\-]{6,30}$", var.ranger_audit_service_account_name)))
    error_message = "ranger_audit_service_account_name can consist only of lowercase letters, numbers and hyphens (-)."
  }
}

variable "idbroker_service_account_name" {
  type = string

  description = "IDBroker service account name"

  default = null

  validation {
    condition     = (var.idbroker_service_account_name == null ? true : length(var.idbroker_service_account_name) >= 6 && length(var.idbroker_service_account_name) <= 30)
    error_message = "The length of idbroker_service_account_name must be between 6 and 30 characters."
  }

  validation {
    condition     = (var.idbroker_service_account_name == null ? true : can(regex("^[a-z0-9\\-]{6,30}$", var.idbroker_service_account_name)))
    error_message = "idbroker_service_account_name can consist only of lowercase letters, numbers and hyphens (-)."
  }
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
    "storage.objects.list",
    "storage.hmacKeys.create",
    "storage.hmacKeys.delete",
    "storage.hmacKeys.get",
    "storage.hmacKeys.list",
    "storage.hmacKeys.update"
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
