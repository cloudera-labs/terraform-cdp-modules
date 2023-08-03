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
variable "azure_region" {
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

# variable "public_key_text" {
#   type = string

#   description = "SSH Public key string for the nodes of the CDP environment"
# }
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
variable "resourcegroup_name" {
  type        = string
  description = "Resource Group name"

  default = null
}

variable "create_vnet" {
  type = bool

  description = "Flag to specify if the VNet should be created"

  default = true
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

variable "cdp_resourcegroup_name" {
  type        = string
  description = "Pre-existing Resource Group for CDP environment. Required if create_vnet is false."

  default = null
}

variable "cdp_vnet_name" {
  type        = string
  description = "Pre-existing VNet Name for CDP environment. Required if create_vnet is false."

  default = null
}

variable "cdp_subnet_names" {
  type        = list(any)
  description = "List of subnet names for CDP Resources. Required if create_vnet is false."

  default = null
}

variable "cdp_gw_subnet_names" {
  type        = list(any)
  description = "List of subnet names for CDP Gateway. Required if create_vnet is false."

  default = null
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

# ------- Authz Resources -------
# Cross Account Application
variable "xaccount_app_name" {
  type = string

  description = "	Cross account application name within Azure Active Directory"

  default = null
}

# Managed Identities
variable "datalake_admin_managed_identity_name" {
  type = string

  description = "Datalake Admin Managed Identity name"

  default = null

}

variable "idbroker_managed_identity_name" {
  type = string

  description = "IDBroker Managed Identity name"

  default = null

}

variable "log_data_access_managed_identity_name" {
  type = string

  description = "Log Data Access Managed Identity name"

  default = null

}

variable "ranger_audit_data_access_managed_identity_name" {
  type = string

  description = "	Ranger Audit Managed Identity name"

  default = null

}

variable "raz_managed_identity_name" {
  type = string

  description = "RAZ Managed Identity name"

  default = null

}

# Role Assignments to Manage Identifies
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