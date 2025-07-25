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
variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in resource descriptions"
}

variable "azure_region" {
  type        = string
  description = "Region which Cloud resources will be created"
}

variable "env_tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

  default = null
}

# ------- # Role Assignments to Manage Identities -------
# IDBroker
variable "idbroker_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "	List of Role Assignments for the IDBroker Managed Identity"

  default = [
    {
      "description" : "Assign VM Contributor Role to IDBroker Identity at Subscription Level",
      "role" : "Virtual Machine Contributor"
    },
    {
      "description" : "Assign Managed Identity Operator Role to IDBroker Identity at Subscription Level",
      "role" : "Managed Identity Operator"
    }
  ]

}

# Datalake admin
variable "datalake_admin_data_container_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Datalake Admin Managed Identity assigned to the Data Storage Container."

  default = [
    {
      "description" : "Assign Storage Blob Data Owner Role to Data Lake Admin Identity at Data Container Level",
      "role" : "Storage Blob Data Owner"
    }
  ]

}

variable "datalake_admin_log_container_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Datalake Admin Managed Identity assigned to the Logs Storage Container."

  default = [
    {
      "description" : "Assign Storage Blob Data Owner Role to Data Lake Admin Identity at Logs Container Level",
      "role" : "Storage Blob Data Owner"
    }
  ]

}

variable "datalake_admin_backup_container_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Datalake Admin Managed Identity assigned to the Backup Storage Container."

  default = [
    {
      "description" : "Assign Storage Blob Data Owner Role to Data Lake Admin Identity at Backup Container Level",
      "role" : "Storage Blob Data Owner"
    }
  ]

}

variable "log_data_access_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Log Data Access Managed Identity."

  default = [
    {
      "description" : "Assign Storage Blob Data Contributor Role to Log Role at Logs and Backup Container level",
      "role" : "Storage Blob Data Contributor"
    }
  ]

}

variable "ranger_audit_data_container_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Ranger Audit Managed Identity assigned to the Data Storage Container."

  default = [
    {
      "description" : "Assign Storage Blob Data Contributor Role to Ranger Audit Role at Data Container level",
      "role" : "Storage Blob Data Contributor"
    }
  ]

}

variable "ranger_audit_log_container_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Ranger Audit Managed Identity assigned to the Log Storage Container."

  default = [
    {
      "description" : "Assign Storage Blob Data Contributor Role to Ranger Audit Role at Logs Container level",
      "role" : "Storage Blob Data Contributor"
    }
  ]

}

variable "ranger_audit_backup_container_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Ranger Audit Managed Identity assigned to the Backup Storage Container."

  default = [
    {
      "description" : "Assign Storage Blob Data Contributor Role to Ranger Audit Role at Backup Container level",
      "role" : "Storage Blob Data Contributor"
    }
  ]

}
variable "raz_storage_role_assignments" {
  type = list(object({
    role        = string
    description = string
    })
  )

  description = "List of Role Assignments for the Ranger Audit Managed Identity assigned to the Log Storage Container."

  default = [
    {
      "description" : "Assign Storage Blob Delegator Role to RAZ Identity at Storage Account level",
      "role" : "Storage Blob Delegator"
    },
    {
      "description" : "Assign Storage Blob Data Owner Role to RAZ Identity at Storage Account level",
      "role" : "Storage Blob Data Owner"
    }
  ]

}

variable "enable_raz" {
  description = "Enable RAZ Managed Identity"
  type        = bool
  default     = true
}