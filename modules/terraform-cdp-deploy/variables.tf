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

  validation {
    condition     = contains(["aws", "azure"], var.infra_type)
    error_message = "Valid values for var: infra_type are (azure, aws)."
  }
}

# NOTE: Waiting on provider fix
# variable "env_tags" {
#   type        = map(any)
#   description = "Tags applied to provisioned resources"

#   default = null
# }

# NOTE: Waiting on provider fix
# variable "agent_source_tag" {
#   type        = map(any)
#   description = "Tag to identify deployment source"

#   default = { agent_source = "tf-cdp-module" }
# }

variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in CDP resource descriptions. This will be used to construct the value of where any of the CDP resource variables (e.g. environment_name, cdp_iam_admin_group_name) are not defined."

  default = null
}

# ------- CDP Environment Deployment - General -------
variable "environment_name" {
  type        = string
  description = "Name of the CDP environment. Defaults to '<env_prefix>-cdp-env' if not specified."

  default = null
}

variable "datalake_name" {
  type        = string
  description = "Name of the CDP datalake. Defaults to '<env_prefix>-<aw|az|gc|>-dl' if not specified."

  default = null
}

variable "cdp_xacccount_credential_name" {
  type        = string
  description = "Name of the CDP Cross Account Credential. Defaults to '<env_prefix>-xaccount-cred' if not specified."

  default = null
}

variable "cdp_admin_group_name" {
  type        = string
  description = "Name of the CDP IAM Admin Group associated with the environment. Defaults to '<env_prefix>-cdp-admin-group' if not specified."

  default = null
}

variable "cdp_user_group_name" {
  type        = string
  description = "Name of the CDP IAM User Group associated with the environment. Defaults to '<env_prefix>-cdp-user-group' if not specified."

  default = null
}

# TODO: Will be re-introducted once provider supports other regions
# variable "cdp_control_plane_region" {
#   type        = string
#   description = "CDP Control Plane Region"

#   # Region is us-west-1 unless explicitly specified
#   default = "us-west-1"
# }

variable "deployment_template" {
  type = string

  description = "Deployment Pattern to use for Cloud resources and CDP"

  validation {
    condition     = contains(["public", "semi-private", "private"], var.deployment_template)
    error_message = "Valid values for var: deployment_template are (public, semi-private, private)."
  }
}

variable "enable_ccm_tunnel" {
  type = bool

  description = "Flag to enable Cluster Connectivity Manager tunnel. If false then access from Cloud to CDP Control Plane CIDRs is required from via SG ingress"

  default = true
}

variable "enable_raz" {
  type = bool

  description = "Flag to enable Ranger Authorization Service (RAZ)"

  default = true
}

variable "multiaz" {
  type = bool

  description = "Flag to specify that the FreeIPA and DataLake instances will be deployed across multi-availability zones. "

  default = true
}

variable "freeipa_instances" {
  type = number

  description = "The number of FreeIPA instances to create in the environment"

  default = 3
}

variable "freeipa_catalog" {
  type = string

  description = "Image catalog to use for FreeIPA image selection"

  default = null
}

variable "freeipa_image_id" {
  type = string

  description = "Image ID to use for creating FreeIPA instances"

  default = null
}

variable "freeipa_instance_type" {
  type = string

  description = "Instance Type to use for creating FreeIPA instances"

  default = null
}

variable "freeipa_recipes" {
  type = set(string)

  description = "The recipes for the FreeIPA cluster"

  default = null
}

variable "proxy_config_name" {
  type = string

  description = "Name of the proxy config to use for the environment."

  default = null
}

variable "workload_analytics" {
  type = bool

  description = "Flag to specify if workload analytics should be enabled for the CDP environment"

  default = true
}

variable "datalake_scale" {
  type = string

  description = "The scale of the datalake. Valid values are LIGHT_DUTY, ENTERPRISE."

  validation {
    condition     = (var.datalake_scale == null ? true : contains(["LIGHT_DUTY", "ENTERPRISE", "MEDIUM_DUTY_HA"], var.datalake_scale))
    error_message = "Valid values for var: datalake_scale are (LIGHT_DUTY, ENTERPRISE, MEDIUM_DUTY_HA)."
  }

  default = null

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

variable "endpoint_access_scheme" {
  type = string

  description = "The scheme for the workload endpoint gateway. PUBLIC creates an external endpoint that can be accessed over the Internet. PRIVATE which restricts the traffic to be internal to the VPC / Vnet. Relevant in Private Networks."

  validation {
    condition     = (var.endpoint_access_scheme == null ? true : contains(["PUBLIC", "PRIVATE"], var.endpoint_access_scheme))
    error_message = "Valid values for var: endpoint_access_scheme are (PUBLIC, PRIVATE)."
  }

  default = null

}

variable "datalake_image" {
  type = object({
    id      = optional(string)
    catalog = optional(string)
  })

  description = "The image to use for the datalake. Can only be used when the 'datalake_version' parameter is set to null. You can use 'catalog' name and/or 'id' for selecting an image."

  default = null
}

variable "datalake_java_version" {
  type = number

  description = "The Java major version to use on the datalake cluster."

  default = null
}

variable "datalake_recipes" {
  type = list(
    object({
      instance_group_name = string,
      recipe_names        = string
    })
  )

  description = "Additional recipes that will be attached on the datalake instances"

  default = null
}

# ------- CDP Environment Deployment - AWS specific -------
variable "encryption_key_arn" {
  type = string

  description = "ARN of the AWS KMS CMK to use for the server-side encryption of AWS storage resources. Only applicable for CDP deployment on AWS."

  default = null
}

variable "datalake_custom_instance_groups" {
  type = list(
    object({
      name          = string,
      instance_type = optional(string)
    })
  )

  description = "A set of custom instance groups for the datalake. Only applicable for CDP deployment on AWS."

  default = null
}

variable "s3_guard_table_name" {
  type = string

  description = "Name for the DynamoDB table backing S3Guard. Only applicable for CDP deployment on AWS."

  default = null
}

# ------- CDP Environment Deployment - Azure specific -------
variable "enable_outbound_load_balancer" {
  type = bool

  description = "Create outbound load balancers for Azure environments. Only applicable for CDP deployment on Azure."

  default = null
}

variable "encryption_key_resource_group_name" {
  type = string

  description = "Name of the existing Azure resource group hosting the Azure Key Vault containing customer managed key which will be used to encrypt the Azure Managed Disk. Only applicable for CDP deployment on Azure."

  default = null
}

variable "encryption_key_url" {
  type = string

  description = "URL of the key which will be used to encrypt the Azure Managed Disks. Only applicable for CDP deployment on Azure."

  default = null
}

# ------- Cloud Service Provider Settings - General -------
variable "region" {
  type        = string
  description = "Region which cloud resources will be created"

}

variable "keypair_name" {
  type = string

  description = "SSH Keypair name in Cloud Service Provider. For CDP deployment on AWS, either 'keypair_name' or 'public_key_text' needs to be set."

  default = null
}

variable "public_key_text" {
  type = string

  description = "SSH Public key string for the nodes of the CDP environment. Required for CDP deployment on Azure. For CDP deployment on AWS, either 'keypair_name' or 'public_key_text' needs to be set."

  default = null
}

variable "data_storage_location" {
  type        = string
  description = "Data storage location. The location has to be in uri format for the cloud provider - i.e. s3a:// for AWS, abfs:// for Azure,  gs://"
}

variable "log_storage_location" {
  type        = string
  description = "Log storage location. The location has to be in uri format for the cloud provider - i.e. s3a:// for AWS, abfs:// for Azure,  gs://"
}

variable "backup_storage_location" {
  type        = string
  description = "Backup storage location. The location has to be in uri format for the cloud provider - i.e. s3a:// for AWS, abfs:// for Azure,  gs://"
}

# ------- Cloud Service Provider Settings - AWS specific -------

variable "aws_vpc_id" {
  type        = string
  description = "AWS Virtual Private Network ID. Required for CDP deployment on AWS."

  default = null
}

variable "aws_public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet ids. Required for CDP deployment on AWS."

  default = null
}

variable "aws_private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet ids. Required for CDP deployment on AWS."

  default = null
}

variable "aws_security_group_default_id" {
  type = string

  description = "ID of the Default Security Group for CDP environment. Required for CDP deployment on AWS."

  default = null
}

variable "aws_security_group_knox_id" {
  type = string

  description = "ID of the Knox Security Group for CDP environment. Required for CDP deployment on AWS."

  default = null
}

variable "aws_datalake_admin_role_arn" {
  type = string

  description = "Datalake Admin Role ARN. Required for CDP deployment on AWS."

  default = null

}

variable "aws_ranger_audit_role_arn" {
  type = string

  description = "Ranger Audit Role ARN. Required for CDP deployment on AWS."

  default = null

}

variable "aws_xaccount_role_arn" {
  type = string

  description = "Cross Account Role ARN. Required for CDP deployment on AWS."

  default = null

}

variable "aws_log_instance_profile_arn" {
  type = string

  description = "Log Instance Profile ARN. Required for CDP deployment on AWS."

  default = null

}

variable "aws_idbroker_instance_profile_arn" {
  type = string

  description = "IDBroker Instance Profile ARN. Required for CDP deployment on AWS."

  default = null
}

# ------- Cloud Service Provider Settings - Azure specific -------
variable "azure_subscription_id" {
  type = string

  description = "Subscription ID where the Azure pre-reqs are created. Required for CDP deployment on Azure."

  default = null
}

variable "azure_tenant_id" {
  type = string

  description = "Tenant ID where the Azure pre-reqs are created. Required for CDP deployment on Azure."

  default = null
}

variable "azure_resource_group_name" {
  type        = string
  description = "Azure Resource Group name. Required for CDP deployment on Azure."

  default = null
}

variable "azure_vnet_name" {
  type        = string
  description = "Azure Virtual Network ID. Required for CDP deployment on Azure."

  default = null

}

variable "azure_aks_private_dns_zone_id" {
  type        = string
  description = "The ID of an existing private DNS zone used for the AKS."

  default = null

}

variable "azure_database_private_dns_zone_id" {
  type        = string
  description = "The ID of an existing private DNS zone used for the database."

  default = null

}

variable "azure_cdp_subnet_names" {
  type        = list(any)
  description = "List of Azure Subnet Names for CDP Resources. Required for CDP deployment on Azure."

  default = null

}

variable "azure_cdp_gateway_subnet_names" {
  type        = list(any)
  description = "List of Azure Subnet Names CDP Endpoint Access Gateway. Required for CDP deployment on Azure."

  default = null

}

variable "azure_security_group_default_uri" {
  type        = string
  description = "Azure Default Security Group URI. Required for CDP deployment on Azure."

  default = null

}

variable "azure_security_group_knox_uri" {
  type        = string
  description = "Azure Knox Security Group URI. Required for CDP deployment on Azure."

  default = null

}

variable "use_public_ips" {
  type = bool

  description = "Use public ip's for the CDP resources created within the Azure network. Required for CDP deployment on Azure."

  default = null
}

variable "use_single_resource_group" {
  type = bool

  description = "Use a single resource group for all provisioned CDP resources. Required for CDP deployment on Azure."

  default = true
}

variable "azure_xaccount_app_uuid" {
  type = string

  description = "UUID for the Azure AD Cross Account Application. Required for CDP deployment on Azure."

  default = null
}

variable "azure_xaccount_app_pword" {
  type = string

  description = "Password for the Azure AD Cross Account Application. Required for CDP deployment on Azure."

  sensitive = true
  default   = null
}

variable "azure_idbroker_identity_id" {
  type = string

  description = "IDBroker Managed Identity ID. Required for CDP deployment on Azure."

  default = null

}

variable "azure_datalakeadmin_identity_id" {
  type = string

  description = "Datalake Admin Managed Identity ID. Required for CDP deployment on Azure."

  default = null

}

variable "azure_ranger_audit_identity_id" {
  type = string

  description = "Ranger Audit Managed Identity ID. Required for CDP deployment on Azure."

  default = null

}

variable "azure_log_identity_id" {
  type = string

  description = "Log Data Access Managed Identity ID. Required for CDP deployment on Azure."

  default = null

}

variable "azure_raz_identity_id" {
  type = string

  description = "RAZ Managed Identity ID. Required for CDP deployment on Azure."

  default = null

}
