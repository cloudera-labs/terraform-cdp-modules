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

  validation {
    condition     = length(var.env_prefix) <= 12
    error_message = "The length of env_prefix must be 12 characters or less."
  }

}

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
variable "separate_network_resource_group" {
  type        = bool
  description = "Flag to specify if separate resource group is to be used for network and Cloudera resources"

  default = false
}

variable "network_resourcegroup_name" {
  type        = string
  description = "Resource Group name for Network resources. Only used if separate_network_resource_group is true. If create_vnet is false this is a pre-existing resource group."

  default = null

  validation {
    condition     = (var.network_resourcegroup_name == null ? true : length(var.network_resourcegroup_name) >= 1 && length(var.network_resourcegroup_name) <= 90)
    error_message = "The length of network_resourcegroup_name must be 90 characters or less."
  }

  validation {
    condition     = (var.network_resourcegroup_name == null ? true : can(regex("^[a-zA-Z0-9\\-\\_\\.]{1,90}$", var.network_resourcegroup_name)))
    error_message = "network_resourcegroup_name can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
  }

}

variable "cdp_resourcegroup_name" {
  type        = string
  description = "Resource Group name for resources. If create_vnet is false this is a pre-existing resource group."

  default = null

  validation {
    condition     = (var.cdp_resourcegroup_name == null ? true : length(var.cdp_resourcegroup_name) >= 1 && length(var.cdp_resourcegroup_name) <= 90)
    error_message = "The length of cdp_resourcegroup_name must be 90 characters or less."
  }

  validation {
    condition     = (var.cdp_resourcegroup_name == null ? true : can(regex("^[a-zA-Z0-9\\-\\_\\.]{1,90}$", var.cdp_resourcegroup_name)))
    error_message = "cdp_resourcegroup_name can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
  }

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

  validation {
    condition     = (var.vnet_name == null ? true : length(var.vnet_name) >= 1 && length(var.vnet_name) <= 80)
    error_message = "The length of vnet_name must be 80 characters or less."
  }

  validation {
    condition     = (var.vnet_name == null ? true : can(regex("^[a-zA-Z0-9\\-\\_\\.]{1,80}$", var.vnet_name)))
    error_message = "vnet_name can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
  }
}

variable "vnet_cidr" {
  type        = string
  description = "VNet CIDR Block. Required if create_vpc is true."

  default = "10.10.0.0/16"
}

variable "create_nat_gateway" {
  type = bool

  description = "Flag to specify if the NAT Gateway should be created. Only applicable if create_vnet is true."

  default = true
}

variable "nat_gateway_name" {
  type        = string
  description = "Name of the NAT Gateway"

  default = null
}

variable "nat_public_ip_name" {
  type        = string
  description = "Name of the NAT Public IP"

  default = null
}

variable "cdp_subnet_range" {
  type        = number
  description = "Size of each (internal) cluster subnet. Required if create_vpc is true."

  default = 19
}

variable "gateway_subnet_range" {
  type        = number
  description = "Size of each gateway subnet. Required if create_vpc is true."

  default = 24
}

variable "delegated_subnet_range" {
  type        = number
  description = "Size of each Postgres Flexible Server delegated subnet. Required if create_vpc is true."

  default = 26
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

variable "cdp_delegated_subnet_names" {
  type        = list(any)
  description = "List of subnet names delegated for Flexible Servers. Required if create_vnet is false."

  default = null
}

variable "subnet_count" {
  type        = string
  description = "Number of CDP Subnets Required"

  default = "3"
}

variable "create_private_flexible_server_resources" {
  type        = bool
  description = "Flag to specify if resources to support a Private Postgres flexible server should be created."

  default = null
}

# Security Groups
variable "security_group_default_name" {
  type = string

  description = "Default Security Group for CDP environment"

  default = null

  validation {
    condition     = (var.security_group_default_name == null ? true : length(var.security_group_default_name) >= 1 && length(var.security_group_default_name) <= 80)
    error_message = "The length of security_group_default_name must be 80 characters or less."
  }

  validation {
    condition     = (var.security_group_default_name == null ? true : can(regex("^[a-zA-Z0-9\\-\\_\\.]{1,80}$", var.security_group_default_name)))
    error_message = "security_group_default_name can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
  }
}

variable "security_group_knox_name" {
  type = string

  description = "Knox Security Group for CDP environment"

  default = null

  validation {
    condition     = (var.security_group_knox_name == null ? true : length(var.security_group_knox_name) >= 1 && length(var.security_group_knox_name) <= 80)
    error_message = "The length of security_group_knox_name must be 80 characters or less."
  }

  validation {
    condition     = (var.security_group_knox_name == null ? true : can(regex("^[a-zA-Z0-9\\-\\_\\.]{1,80}$", var.security_group_knox_name)))
    error_message = "security_group_knox_name can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
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

variable "cdp_subnets_private_endpoint_network_policies" {
  type = string

  description = "Enable or Disable network policies for the private endpoint on the CDP subnets"

  validation {
    condition     = (var.cdp_subnets_private_endpoint_network_policies == null ? true : contains(["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.cdp_subnets_private_endpoint_network_policies))
    error_message = "Valid values for var: cdp_subnets_private_endpoint_network_policies are (Disabled, Enabled, NetworkSecurityGroupEnabled, RouteTableEnabled)."
  }

  default = "Enabled"
}

variable "gateway_subnets_private_endpoint_network_policies" {
  type = string

  description = "Enable or Disable network policies for the private endpoint on the Gateway subnets"

  validation {
    condition     = (var.gateway_subnets_private_endpoint_network_policies == null ? true : contains(["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.gateway_subnets_private_endpoint_network_policies))
    error_message = "Valid values for var: gateway_subnets_private_endpoint_network_policies are (Disabled, Enabled, NetworkSecurityGroupEnabled, RouteTableEnabled)."
  }

  default = "Enabled"
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

  validation {
    condition     = (var.data_storage == null ? true : (length(var.data_storage.data_storage_bucket) >= 3 && length(var.data_storage.data_storage_bucket) <= 24))
    error_message = "The length of data_storage_bucket must be between 3 and 24 characters."
  }
  validation {
    condition     = (var.data_storage == null ? true : (can(regex("^[a-z0-9]{1,24}$", var.data_storage.data_storage_bucket))))
    error_message = "data_storage_bucket can consist only of lowercase letters and numbers."
  }
}

variable "log_storage" {
  type = object({
    log_storage_bucket = string
    log_storage_object = string
  })

  description = "Optional log locations for CDP environment. If not provided follow the data_storage variable"

  default = null

  validation {
    condition     = (var.log_storage == null ? true : (length(var.log_storage.log_storage_bucket) >= 3 && length(var.log_storage.log_storage_bucket) <= 24))
    error_message = "The length of log_storage_bucket must be between 3 and 24 characters."
  }
  validation {
    condition     = (var.log_storage == null ? true : (can(regex("^[a-z0-9]{1,24}$", var.log_storage.log_storage_bucket))))
    error_message = "log_storage_bucket can consist only of lowercase letters and numbers."
  }
}

variable "backup_storage" {
  type = object({
    backup_storage_bucket = string
    backup_storage_object = string
  })

  description = "Optional Backup location for CDP environment. If not provided follow the data_storage variable"

  default = null

  validation {
    condition     = (var.backup_storage == null ? true : (length(var.backup_storage.backup_storage_bucket) >= 3 && length(var.log_storage.log_storage_bucket) <= 24))
    error_message = "The length of backup_storage_bucket must be between 3 and 24 characters."
  }
  validation {
    condition     = (var.backup_storage == null ? true : (can(regex("^[a-z0-9]{1,24}$", var.backup_storage.backup_storage_bucket))))
    error_message = "backup_storage_bucket can consist only of lowercase letters and numbers."
  }
}

variable "storage_public_network_access_enabled" {
  type = bool

  description = "Enable public_network_access_enabled for storage accounts."

  default = true
}

variable "create_azure_storage_network_rules" {
  type = bool

  description = "Enable creation of network rules for the Azure Storage Accounts."

  default = false
}

variable "create_azure_storage_private_endpoints" {
  type = bool

  description = "Flag to specify if Private Endpoints are created for each storage account."

  default = true
}

# ------- Authz Resources -------
# Cross Account Application
variable "xaccount_app_name" {
  type = string

  description = "	Cross account application name within Azure Active Directory"

  default = null

}

variable "xaccount_app_role_assignments" {
  type = list(object({
    role        = string
    description = string
    scope       = optional(string)
    })
  )

  description = "List of Role Assignments for the Cross Account Service Principal. If scope is not specified then scope is set to var.azure_subscription_id"

  default = [
    {
      "description" : "Contributor Role to Cross Account Service Principal at Subscription Level",
      "role" : "Contributor"
    }
  ]
}

# Managed Identities
variable "datalake_admin_managed_identity_name" {
  type = string

  description = "Datalake Admin Managed Identity name"

  default = null

  validation {
    condition     = (var.datalake_admin_managed_identity_name == null ? true : length(var.datalake_admin_managed_identity_name) <= 128)
    error_message = "The length of datalake_admin_managed_identity_name must be 128 characters or less."
  }
  validation {
    condition     = (var.datalake_admin_managed_identity_name == null ? true : can(regex("^[a-zA-Z0-9-_]{1,128}$", var.datalake_admin_managed_identity_name)))
    error_message = "datalake_admin_managed_identity_name can consist only of letters, numbers, hyphens (-) and underscores (_)."
  }
}

variable "idbroker_managed_identity_name" {
  type = string

  description = "IDBroker Managed Identity name"

  default = null

  validation {
    condition     = (var.idbroker_managed_identity_name == null ? true : length(var.idbroker_managed_identity_name) <= 128)
    error_message = "The length of idbroker_managed_identity_name must be 128 characters or less."
  }
  validation {
    condition     = (var.idbroker_managed_identity_name == null ? true : can(regex("^[a-zA-Z0-9-_]{1,128}$", var.idbroker_managed_identity_name)))
    error_message = "idbroker_managed_identity_name can consist only of letters, numbers, hyphens (-) and underscores (_)."
  }
}

variable "log_data_access_managed_identity_name" {
  type = string

  description = "Log Data Access Managed Identity name"

  default = null

  validation {
    condition     = (var.log_data_access_managed_identity_name == null ? true : length(var.log_data_access_managed_identity_name) <= 128)
    error_message = "The length of log_data_access_managed_identity_name must be 128 characters or less."
  }
  validation {
    condition     = (var.log_data_access_managed_identity_name == null ? true : can(regex("^[a-zA-Z0-9-_]{1,128}$", var.log_data_access_managed_identity_name)))
    error_message = "log_data_access_managed_identity_name can consist only of letters, numbers, hyphens (-) and underscores (_)."
  }
}

variable "ranger_audit_data_access_managed_identity_name" {
  type = string

  description = "	Ranger Audit Managed Identity name"

  default = null

  validation {
    condition     = (var.ranger_audit_data_access_managed_identity_name == null ? true : length(var.ranger_audit_data_access_managed_identity_name) <= 128)
    error_message = "The length of ranger_audit_data_access_managed_identity_name must be 128 characters or less."
  }
  validation {
    condition     = (var.ranger_audit_data_access_managed_identity_name == null ? true : can(regex("^[a-zA-Z0-9-_]{1,128}$", var.ranger_audit_data_access_managed_identity_name)))
    error_message = "ranger_audit_data_access_managed_identity_name can consist only of letters, numbers, hyphens (-) and underscores (_)."
  }
}

variable "raz_managed_identity_name" {
  type = string

  description = "RAZ Managed Identity name"

  default = null

  validation {
    condition     = (var.raz_managed_identity_name == null ? true : length(var.raz_managed_identity_name) <= 128)
    error_message = "The length of raz_managed_identity_name must be 128 characters or less."
  }
  validation {
    condition     = (var.raz_managed_identity_name == null ? true : can(regex("^[a-zA-Z0-9-_]{1,128}$", var.raz_managed_identity_name)))
    error_message = "raz_managed_identity_name can consist only of letters, numbers, hyphens (-) and underscores (_)."
  }
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

variable "public_key_text" {
  type = string

  description = "SSH Public key string for the nodes of the CDP environment"
  default     = null
}

variable "create_azure_cml_nfs" {
  type        = bool
  description = "Whether to create NFS for CML"
  default     = false
}

variable "nfs_file_share_name" {
  type        = string
  description = "nfs file share name"
  default     = null

  validation {
    condition     = (var.nfs_file_share_name == null ? true : length(var.nfs_file_share_name) >= 3 && length(var.nfs_file_share_name) <= 63)
    error_message = "The length of nfs_file_share_name must be between 3 and 63 characters."
  }

  validation {
    condition     = (var.nfs_file_share_name == null ? true : can(regex("^[a-z0-9-]{1,63}$", var.nfs_file_share_name)))
    error_message = "nfs_file_share_name can consist only of lowercase letters, numbers, hyphens (-)."
  }
}

variable "nfs_storage_account_name" {
  type        = string
  description = "NFS Storage account name"
  default     = null

  validation {
    condition     = (var.nfs_storage_account_name == null ? true : (length(var.nfs_storage_account_name) >= 3 && length(var.nfs_storage_account_name) <= 24))
    error_message = "The length of nfs_storage_account_name must be between 3 and 24 characters."
  }
  validation {
    condition     = (var.nfs_storage_account_name == null ? true : (can(regex("^[a-z0-9]{1,24}$", var.nfs_storage_account_name))))
    error_message = "nfs_storage_account_name can consist only of lowercase letters and numbers."
  }
}

variable "create_vm_mounting_nfs" {
  type        = bool
  description = "Whether to create a VM which mounts this NFS"
  default     = true
}

variable "nfs_file_share_size" {
  type        = number
  description = "NFS File Share size"
  default     = 100
}

# ------- Support for existing Authz resources -------
# Cross Account Application
variable "existing_xaccount_app_client_id" {
  type        = string
  description = "Client ID of existing Azure AD Application for Cloudera Cross Account. If set then no application or SPN resources are created."

  default = null
}

variable "existing_xaccount_app_pword" {
  type        = string
  description = "Password of existing Azure AD Application for Cloudera Cross Account. If set then no application or SPN resources are created."

  default = null
}

# ------- Support for existing Security Groups -------
variable "existing_default_security_group_name" {
  type        = string
  description = "Name of existing Default Security Group for Cloudera on cloud environment. If set then no security group or ingress rules are created for the Default SG."

  default = null
}

variable "existing_knox_security_group_name" {
  type        = string
  description = "Name of existing Knox Security Group for Cloudera on cloud environment. If set then no security group or ingress rules are created for the Knox SG."

  default = null
}