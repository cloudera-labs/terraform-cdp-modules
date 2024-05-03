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
variable "tags" {
  type        = map(any)
  description = "Tags applied to provisioned resources"

}

# ------- CDP Environment Deployment -------
variable "environment_name" {
  type        = string
  description = "Name of the CDP environment."

}

variable "datalake_name" {
  type        = string
  description = "Name of the CDP DataLake."

}

variable "create_cdp_credential" {
  type = bool

  description = "Flag to specify if the CDP Cross Account Credential should be created. If set to false then cdp_xacccount_credential_name should be a valid pre-existing credential."

}

variable "cdp_xacccount_credential_name" {
  type        = string
  description = "Name of the CDP Cross Account Credential. If create_cdp_credential is set to false then this should should be a valid pre-existing credential."

}

variable "cdp_admin_group_name" {
  type        = string
  description = "Name of the CDP IAM Admin Group associated with the environment."

}

variable "cdp_user_group_name" {
  type        = string
  description = "Name of the CDP IAM User Group associated with the environment."

}

variable "enable_ccm_tunnel" {
  type = bool

  description = "Flag to enable Cluster Connectivity Manager tunnel. If false then access from Cloud to CDP Control Plane CIDRs is required from via SG ingress"

}

variable "enable_raz" {
  type = bool

  description = "Flag to enable Ranger Authorization Service (RAZ)"

}

variable "multiaz" {
  type = bool

  description = "Flag to specify that the FreeIPA and DataLake instances will be deployed across multi-availability zones"

}

variable "environment_async_creation" {
  type = bool

  description = "Flag to specify if Terraform should wait for CDP environment resource creation/deletion"

}

variable "environment_polling_timeout" {
  type = number

  description = " Timeout value in minutes for how long to poll for CDP Environment resource creation/deletion"

}

variable "freeipa_instances" {
  type = number

  description = "The number of FreeIPA instances to create in the environment"

}

variable "freeipa_catalog" {
  type = string

  description = "Image catalog to use for FreeIPA image selection"

}

variable "freeipa_image_id" {
  type = string

  description = "Image ID to use for creating FreeIPA instances"

}

variable "freeipa_instance_type" {
  type = string

  description = "Instance Type to use for creating FreeIPA instances"

}

variable "freeipa_recipes" {
  type = set(string)

  description = "The recipes for the FreeIPA cluster"

}

variable "workload_analytics" {
  type = bool

  description = "Flag to specify if workload analytics should be enabled for the CDP environment"

}

variable "enable_outbound_load_balancer" {
  type = bool

  description = "Create outbound load balancers for Azure environments."

  default = null
}

variable "encryption_key_resource_group_name" {
  type = string

  description = "Name of the existing Azure resource group hosting the Azure Key Vault containing customer managed key which will be used to encrypt the Azure Managed Disk."

}

variable "encryption_key_url" {
  type = string

  description = "URL of the key which will be used to encrypt the Azure Managed Disks."

}

variable "encryption_at_host" {
  type = bool

  description = "Provision resources with host encryption enabled"

}

variable "proxy_config_name" {
  type = string

  description = "Name of the proxy config to use for the environment."

}


variable "datalake_scale" {
  type = string

  description = "The scale of the datalake. Valid values are LIGHT_DUTY, ENTERPRISE."

  validation {
    condition     = contains(["LIGHT_DUTY", "ENTERPRISE", "MEDIUM_DUTY_HA"], var.datalake_scale)
    error_message = "Valid values for var: datalake_scale are (LIGHT_DUTY, ENTERPRISE, MEDIUM_DUTY_HA)."
  }

}

variable "datalake_version" {
  type = string

  description = "The Datalake Runtime version. Valid values are latest or a semantic version, e.g. 7.2.17"

  validation {
    condition     = (var.datalake_version == "latest" ? true : length(regexall("\\d+\\.\\d+.\\d+", var.datalake_version)) > 0)
    error_message = "Valid values for var: datalake_version are 'latest' or a semantic versioning conventions."
  }

  default = "latest"
}

variable "datalake_image" {
  type = object({
    id      = optional(string)
    catalog = optional(string)
  })

  description = "The image to use for the datalake. Can only be used when the 'datalake_version' parameter is set to null. You can use 'catalog' name and/or 'id' for selecting an image."

}

variable "datalake_java_version" {
  type = number

  description = "The Java major version to use on the datalake cluster."

}

variable "datalake_recipes" {
  type = set(
    object({
      instance_group_name = string,
      recipe_names        = set(string)
    })
  )

  description = "Additional recipes that will be attached on the datalake instances"

}

variable "datalake_async_creation" {
  type = bool

  description = "Flag to specify if Terraform should wait for CDP datalake resource creation/deletion"

}

variable "datalake_polling_timeout" {
  type = number

  description = "Timeout value in minutes for how long to poll for CDP datalake resource creation/deletion"

}
# ------- Cloud Service Provider Settings -------
variable "subscription_id" {
  type = string

  description = "Subscription ID where the Azure pre-reqs are created"

  validation {
    condition     = var.subscription_id != null
    error_message = "Valid values for var: subscription_id must be a existing Azure Subscription."
  }


}

variable "tenant_id" {
  type = string

  description = "Tenant ID where the Azure pre-reqs are created"

  validation {
    condition     = var.tenant_id != null
    error_message = "Valid values for var: tenant_id must be a existing Azure Tenant."
  }

}

variable "region" {
  type        = string
  description = "Region which Cloud resources will be created"

}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name"

  validation {
    condition     = var.resource_group_name != null
    error_message = "Valid values for var: resource_group_name must be a existing Azure Resource group."
  }

}

variable "vnet_name" {
  type        = string
  description = "Azure Virtual Network ID."

  validation {
    condition     = var.vnet_name != null
    error_message = "Valid values for var: vnet_name must be a existing Azure Virtual Network."
  }

}

variable "cdp_subnet_names" {
  type        = list(any)
  description = "Azure Subnet Names for CDP resources."

  validation {
    condition     = var.cdp_subnet_names != null
    error_message = "Valid values for var: cdp_subnet_names must be a list of existing Azure Virtual Subnets."
  }

}

variable "azure_aks_private_dns_zone_id" {
  type        = string
  description = "The ID of an existing private DNS zone used for the AKS."

}

variable "azure_database_private_dns_zone_id" {
  type        = string
  description = "The ID of an existing private DNS zone used for the database."

}

variable "create_private_endpoints" {
  type        = bool
  description = "Azure Postgres will be configured with Private Endpoint and a Private DNS Zone."

}

variable "cdp_gateway_subnet_names" {
  type        = list(any)
  description = "Azure Subnet Names for Endpoint Access Gateway."

  validation {
    condition     = var.cdp_gateway_subnet_names != null
    error_message = "Valid values for var: cdp_gateway_subnet_names must be a list of existing Azure Virtual Subnets."
  }

}

variable "cdp_flexible_server_delegated_subnet_names" {
  type        = list(any)
  description = "Azure Subnet Names delegated for Private Flexible servers."

  validation {
    condition     = var.cdp_flexible_server_delegated_subnet_names != null
    error_message = "Valid values for var: cdp_flexible_server_delegated_subnet_names must be a list of existing Azure Virtual Subnets."
  }

}

variable "security_group_default_uri" {
  type        = string
  description = "Azure Default Security Group URI."

  validation {
    condition     = var.security_group_default_uri != null
    error_message = "Valid values for var: security_group_default_uri must be a valid Azure SG Uri for the Default SG."
  }

}

variable "security_group_knox_uri" {
  type        = string
  description = "Azure Knox Security Group URI."

  validation {
    condition     = var.security_group_knox_uri != null
    error_message = "Valid values for var: security_group_knox_uri must be a valid Azure SG Uri for the Knox SG."
  }

}

variable "endpoint_access_scheme" {
  type = string

  description = "The scheme for the workload endpoint gateway. PUBLIC creates an external endpoint that can be accessed over the Internet. PRIVATE which restricts the traffic to be internal to the VPC / Vnet. Relevant in Private Networks."

  validation {
    condition     = contains(["PUBLIC", "PRIVATE"], var.endpoint_access_scheme)
    error_message = "Valid values for var: endpoint_access_scheme are (PUBLIC, PRIVATE)."
  }
}

variable "public_key_text" {
  type = string

  description = "SSH Public key string for the nodes of the CDP environment"
}

variable "use_single_resource_group" {
  type = bool

  description = "Use a single resource group for all provisioned CDP resources"

}

variable "use_public_ips" {
  type = bool

  description = "Use public ip's for the CDP resources created within the Azure network"

}

variable "data_storage_location" {
  type        = string
  description = "Data storage location."
}

variable "log_storage_location" {
  type        = string
  description = "Log storage location."
}

variable "backup_storage_location" {
  type        = string
  description = "Backup storage location."
}

variable "xaccount_app_uuid" {
  type = string

  description = "UUID for the Azure AD Cross Account Application."

  validation {
    condition     = var.xaccount_app_uuid != null
    error_message = "Valid values for var: xaccount_app_uuid must be a valid uuid for the Azure AD Cross Account Application."
  }

}

variable "xaccount_app_pword" {
  type = string

  description = "Password for the Azure AD Cross Account Application."

  sensitive = true
  validation {
    condition     = var.xaccount_app_pword != null
    error_message = "Valid values for var: xaccount_app_pword must be a valid password for the Azure AD Cross Account Application."
  }

}

variable "idbroker_identity_id" {
  type = string

  description = "IDBroker Managed Identity ID."

  validation {
    condition     = var.idbroker_identity_id != null
    error_message = "Valid values for var: idbroker_identity_id must be a valid ID for IDBroker Managed Identity."
  }

}

variable "datalakeadmin_identity_id" {
  type = string

  description = "Datalake Admin Managed Identity ID."

  validation {
    condition     = var.datalakeadmin_identity_id != null
    error_message = "Valid values for var: datalakeadmin_identity_id must be a valid ID for Datalake Admin Managed Identity."
  }

}

variable "ranger_audit_identity_id" {
  type = string

  description = "Ranger Audit Managed Identity ID."

  validation {
    condition     = var.ranger_audit_identity_id != null
    error_message = "Valid values for var: ranger_audit_identity_id must be a valid ID for Ranger Audit Managed Identity."
  }


}

variable "log_identity_id" {
  type = string

  description = "Log Data Access Managed Identity ID."

  validation {
    condition     = var.log_identity_id != null
    error_message = "Valid values for var: log_identity_id must be a valid ID for Log Data Access Managed Identity."
  }


}

variable "raz_identity_id" {
  type = string

  description = "RAZ Managed Identity ID."

  validation {
    condition     = var.raz_identity_id != null
    error_message = "Valid values for var: raz_identity_id must be a valid ID for RAZ Managed Identity."
  }

}
