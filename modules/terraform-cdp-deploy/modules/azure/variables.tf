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

variable "cdp_xacccount_credential_name" {
  type        = string
  description = "Name of the CDP Cross Account Credential."

}

variable "cdp_admin_group_name" {
  type        = string
  description = "Name of the CDP IAM Admin Group associated with the environment."

}

variable "cdp_user_group_name" {
  type        = string
  description = "Name of the CDP IAM User Group associated with the environment."

}

variable "cdp_profile" {
  type        = string
  description = "Profile for CDP credentials"

}

variable "cdp_control_plane_region" {
  type        = string
  description = "CDP Control Plane Region"

}

variable "enable_ccm_tunnel" {
  type = bool

  description = "Flag to enable Cluster Connectivity Manager tunnel. If false then access from Cloud to CDP Control Plane CIDRs is required from via SG ingress"

}

variable "enable_raz" {
  type = bool

  description = "Flag to enable Ranger Authorization Service (RAZ)"

}

variable "freeipa_instances" {
  type = number

  description = "The number of FreeIPA instances to create in the environment"

}


variable "workload_analytics" {
  type = bool

  description = "Flag to specify if workload analytics should be enabled for the CDP environment"

}


variable "datalake_scale" {
  type = string

  description = "The scale of the datalake. Valid values are LIGHT_DUTY, MEDIUM_DUTY_HA."

  validation {
    condition     = contains(["LIGHT_DUTY", "MEDIUM_DUTY_HA"], var.datalake_scale)
    error_message = "Valid values for var: datalake_scale are (LIGHT_DUTY, MEDIUM_DUTY_HA)."
  }

}

variable "datalake_version" {
  type = string

  description = "The Datalake Runtime version. Valid values are semantic versions, e.g. 7.2.16"

  validation {
    condition     = length(regexall("\\d+\\.\\d+.\\d+", var.datalake_version)) > 0
    error_message = "Valid values for var: datalake_version must match semantic versioning conventions."
  }

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

variable "subnet_names" {
  type        = list(any)
  description = "Azure Subnet Names."

  validation {
    condition     = var.subnet_names != null
    error_message = "Valid values for var: subnet_names must be a list of existing Azure Virtual Subnets."
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
