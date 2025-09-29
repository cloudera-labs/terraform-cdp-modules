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
variable "azure_region" {
  type        = string
  description = "Region which Cloud resources will be created"

}

variable "tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

  default = null
}


# ------- Azure specific settings -------
variable "resource_group_name" {
  type        = string
  description = "Azrue Resource Group for Managed Identities."

}

# IDBroker Managed Identity
variable "idbroker_managed_identity_name" {
  type = string

  description = "IDBroker Managed Identity name"

  validation {
    condition     = length(var.idbroker_managed_identity_name) <= 128
    error_message = "The length of idbroker_managed_identity_name must be 128 characters or less."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]{1,128}$", var.idbroker_managed_identity_name))
    error_message = "idbroker_managed_identity_name can consist only of letters, numbers, hyphens (-) and underscores (_)."
  }
}

variable "idbroker_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "	List of Role Assignments for the IDBroker Managed Identity"

}

# Datalake Admin Managed Identity
variable "datalake_admin_managed_identity_name" {
  type = string

  description = "Datalake Admin Managed Identity name"

  validation {
    condition     = length(var.datalake_admin_managed_identity_name) <= 128
    error_message = "The length of datalake_admin_managed_identity_name must be 128 characters or less."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]{1,128}$", var.datalake_admin_managed_identity_name))
    error_message = "datalake_admin_managed_identity_name can consist only of letters, numbers, hyphens (-) and underscores (_)."
  }
}

variable "datalake_admin_data_container_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Datalake Admin Managed Identity assigned to the Data Storage Container."

}

variable "datalake_admin_log_container_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Datalake Admin Managed Identity assigned to the Logs Storage Container."

}

variable "datalake_admin_backup_container_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Datalake Admin Managed Identity assigned to the Backup Storage Container."

}

# Log Data Access Managed Identity
variable "log_data_access_managed_identity_name" {
  type = string

  description = "Log Data Access Managed Identity name"

  validation {
    condition     = length(var.log_data_access_managed_identity_name) <= 128
    error_message = "The length of log_data_access_managed_identity_name must be 128 characters or less."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]{1,128}$", var.log_data_access_managed_identity_name))
    error_message = "log_data_access_managed_identity_name can consist only of letters, numbers, hyphens (-) and underscores (_)."
  }
}

variable "log_data_access_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Log Data Access Managed Identity."

}

# Ranger Audit
variable "ranger_audit_data_access_managed_identity_name" {
  type = string

  description = "	Ranger Audit Managed Identity name"

  validation {
    condition     = length(var.ranger_audit_data_access_managed_identity_name) <= 128
    error_message = "The length of ranger_audit_data_access_managed_identity_name must be 128 characters or less."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]{1,128}$", var.ranger_audit_data_access_managed_identity_name))
    error_message = "ranger_audit_data_access_managed_identity_name can consist only of letters, numbers, hyphens (-) and underscores (_)."
  }
}

variable "ranger_audit_data_container_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Ranger Audit Managed Identity assigned to the Data Storage Container."

}

variable "ranger_audit_log_container_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Ranger Audit Managed Identity assigned to the Log Storage Container."

}

variable "ranger_audit_backup_container_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Ranger Audit Managed Identity assigned to the Backup Storage Container."

}

# Raz
variable "enable_raz" {
  type = bool

  description = "Flag to enable Ranger Authorization Service (RAZ)"

}

variable "raz_managed_identity_name" {
  type = string

  description = "RAZ Managed Identity name"

  validation {
    condition     = length(var.raz_managed_identity_name) <= 128
    error_message = "The length of raz_managed_identity_name must be 128 characters or less."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]{1,128}$", var.raz_managed_identity_name))
    error_message = "raz_managed_identity_name can consist only of letters, numbers, hyphens (-) and underscores (_)."
  }
}

variable "raz_storage_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Ranger Audit Managed Identity assigned to the Log Storage Container."

}

# ------- Storage Locations -------

variable "data_storage_container_id" {
  type = string

  description = "Resource Manager ID of the Data Storage Container"

}

variable "log_storage_container_id" {
  type = string

  description = "Resource Manager ID of the Log Storage Container"

}

variable "backup_storage_container_id" {
  type = string

  description = "Resource Manager ID of the Backup Storage Container"

}

variable "data_storage_account_id" {
  type = string

  description = "Resource Manager ID of the Data Storage Account. Required only if RAZ is enabled."

  default = null

  validation {
    condition     = var.enable_raz ? var.data_storage_account_id != null : true
    error_message = "data_storage_account_id must be provided if RAZ is enabled."
  }
}