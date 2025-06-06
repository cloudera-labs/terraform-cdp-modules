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
variable "infra_type" {
  type        = string
  description = "Cloud Provider to deploy CDP."

  validation {
    condition     = contains(["aws", "azure", "gcp"], var.infra_type)
    error_message = "Valid values for var: infra_type are (azure, aws, gcp)."
  }
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
  description = "Shorthand name for the environment. Used in CDP resource descriptions. This will be used to construct the value of where any of the CDP resource variables (e.g. environment_name, cdp_iam_admin_group_name) are not defined."

  validation {
    condition     = length(var.env_prefix) <= 18
    error_message = "The length of env_prefix must be 18 characters or less."
  }
  validation {
    condition     = (var.env_prefix == null ? true : can(regex("^[a-z0-9-]{1,18}$", var.env_prefix)))
    error_message = "env_prefix can consist only of lowercase letters, numbers, and hyphens (-)."
  }
}

# ------- CDP Environment Deployment - General -------
variable "environment_name" {
  type        = string
  description = "Name of the CDP environment. Defaults to '<env_prefix>-cdp-env' if not specified."

  default = null

  validation {
    condition     = (var.environment_name == null ? true : length(var.environment_name) >= 5 && length(var.environment_name) <= 28)
    error_message = "The length of environment_name must be between 5 and 28 characters."
  }
  validation {
    condition     = (var.environment_name == null ? true : can(regex("^[a-z0-9-]{1,90}$", var.environment_name)))
    error_message = "environment_name can consist only of lowercase letters, numbers, and hyphens (-)."
  }
}

variable "environment_description" {
  type        = string
  description = "Description of CDP environment"

  default = null
}

variable "environment_cascading_delete" {
  type        = bool
  description = "Flag to enable cascading delete of environment and associated resources"

  default = null
}

variable "datalake_name" {
  type        = string
  description = "Name of the CDP datalake. Defaults to '<env_prefix>-<aw|az|gc|>-dl' if not specified."

  default = null

  validation {
    condition     = (var.datalake_name == null ? true : length(var.datalake_name) >= 5 && length(var.datalake_name) <= 40)
    error_message = "The length of datalake_name must be between 5 and 40 characters."
  }

  validation {
    condition     = (var.datalake_name == null ? true : can(regex("^[a-z0-9-]{5,40}$", var.datalake_name)))
    error_message = "datalake_name can consist only of lowercase letters, numbers, and hyphens (-)."
  }
}

variable "create_cdp_credential" {
  type = bool

  description = "Flag to specify if the CDP Cross Account Credential should be created. If set to false then cdp_xacccount_credential_name should be a valid pre-existing credential."

  default = true
}

variable "cdp_xacccount_credential_name" {
  type        = string
  description = "Name of the CDP Cross Account Credential. Defaults to '<env_prefix>-xaccount-cred' if not specified. If create_cdp_credential is set to false then this should should be a valid pre-existing credential."

  default = null

  validation {
    condition     = (var.cdp_xacccount_credential_name == null ? true : length(var.cdp_xacccount_credential_name) >= 5 && length(var.cdp_xacccount_credential_name) <= 100)
    error_message = "The length of cdp_xacccount_credential_name must be between 5 and 100 characters."
  }

  validation {
    condition     = (var.cdp_xacccount_credential_name == null ? true : can(regex("^[a-z0-9-]{5,100}$", var.cdp_xacccount_credential_name)))
    error_message = "cdp_xacccount_credential_name can consist only of lowercase letters, numbers, and hyphens (-)."
  }

}

variable "cdp_groups" {
  type = set(object({
    name                          = string
    create_group                  = bool
    sync_membership_on_user_login = optional(bool)
    add_id_broker_mappings        = bool
    })
  )

  description = "List of CDP Groups to be added to the IDBroker mappings of the environment. If create_group is set to true then the group will be created."

  validation {
    condition = (var.cdp_groups == null ? true : alltrue([
      for grp in var.cdp_groups :
      length(grp.name) >= 1 && length(grp.name) <= 64
    ]))
    error_message = "The length of all CDP group names must be 64 characters or less."
  }
  validation {
    condition = (var.cdp_groups == null ? true : alltrue([
      for grp in var.cdp_groups :
      can(regex("^[a-zA-Z0-9\\-\\_\\.]{1,90}$", grp.name))
    ]))
    error_message = "CDP group names can consist only of letters, numbers, dots (.), hyphens (-) and underscores (_)."
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

variable "environment_async_creation" {
  type = bool

  description = "Flag to specify if Terraform should wait for CDP environment resource creation/deletion"

  default = false
}

variable "environment_call_failure_threshold" {
  type = number

  description = "Threshold value that specifies how many times should a single CDP Environment API call failure happen before giving up the polling"

  default = 3
}

variable "environment_polling_timeout" {
  type = number

  description = " Timeout value in minutes for how long to poll for CDP Environment resource creation/deletion"

  default = 120
}

variable "multiaz" {
  type = bool

  description = "Flag to specify that the FreeIPA and DataLake instances will be deployed across multi-availability zones."

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

variable "freeipa_os" {
  type = string

  description = "The Operating System to be used for the FreeIPA instances"

  validation {
    condition     = (var.freeipa_os == null ? true : contains(["redhat8", "centos7"], var.freeipa_os))
    error_message = "Valid values for var: freeipa_os are (redhat8, centos7)."
  }

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

variable "compute_cluster_enabled" {
  type = bool

  description = "Enable externalized compute cluster for the environment"

  default = false
}

variable "compute_cluster_configuration" {
  type = object({
    kube_api_authorized_ip_ranges = optional(set(string))
    outbound_type                 = optional(string)
    private_cluster               = optional(bool)
    worker_node_subnets           = optional(set(string))
  })

  description = "Kubernetes configuration for the externalized compute cluster"

  default = null
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
    condition = (var.datalake_version == null ? true :
      (var.datalake_version == "latest" ? true :
    length(regexall("\\d+\\.\\d+.\\d+", var.datalake_version)) > 0))
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
    id           = optional(string)
    catalog_name = optional(string)
    os           = optional(string)
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
  type = set(
    object({
      instance_group_name = string,
      recipe_names        = set(string)
    })
  )

  description = "Additional recipes that will be attached on the datalake instances"

  default = null
}

variable "datalake_async_creation" {
  type = bool

  description = "Flag to specify if Terraform should wait for CDP datalake resource creation/deletion"

  default = false
}

variable "datalake_call_failure_threshold" {
  type = number

  description = "Threshold value that specifies how many times should a single CDP Datalake API call failure happen before giving up the polling"

  default = 3
}

variable "datalake_polling_timeout" {
  type = number

  description = "Timeout value in minutes for how long to poll for CDP datalake resource creation/deletion"

  default = 90
}

# ------- CDP Environment Deployment - AWS specific -------
variable "encryption_key_arn" {
  type = string

  description = "ARN of the AWS KMS CMK to use for the server-side encryption of AWS storage resources. Only applicable for CDP deployment on AWS."

  default = null

  validation {
    condition     = (var.encryption_key_arn == null ? true : (var.infra_type == "aws" ? true : false))
    error_message = "encryption_key_arn can only be set when 'infra_type' is set to 'aws'."
  }
}

variable "s3_guard_table_name" {
  type = string

  description = "Name for the DynamoDB table backing S3Guard. Only applicable for CDP deployment on AWS."

  default = null

  validation {
    condition     = (var.s3_guard_table_name == null ? true : (var.infra_type == "aws" ? true : false))
    error_message = "s3_guard_table_name can only be set when 'infra_type' is set to 'aws'."
  }
}

# ------- CDP Environment Deployment - Azure specific -------
variable "enable_outbound_load_balancer" {
  type = bool

  description = "Create outbound load balancers for Azure environments. Only applicable for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.enable_outbound_load_balancer == null ? true : (var.infra_type == "azure" ? true : false))
    error_message = "enable_outbound_load_balancer can only be set when 'infra_type' is set to 'azure'."
  }
}

variable "encryption_key_resource_group_name" {
  type = string

  description = "Name of the existing Azure resource group hosting the Azure Key Vault containing customer managed key which will be used to encrypt the Azure Managed Disk. Only applicable for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.encryption_key_resource_group_name == null ? true : (var.infra_type == "azure" ? true : false))
    error_message = "encryption_key_resource_group_name can only be set when 'infra_type' is set to 'azure'."
  }
}

variable "encryption_key_url" {
  type = string

  description = "URL of the key which will be used to encrypt the Azure Managed Disks. Only applicable for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.encryption_key_url == null ? true : (var.infra_type == "azure" ? true : false))
    error_message = "encryption_key_url can only be set when 'infra_type' is set to 'azure'."
  }
}

variable "encryption_at_host" {
  type = bool

  description = "Provision resources with host encryption enabled. Only applicable for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.encryption_at_host == null ? true : (var.infra_type == "azure" ? true : false))
    error_message = "encryption_at_host can only be set when 'infra_type' is set to 'azure'."
  }
}

variable "encryption_user_managed_identity" {
  type = string

  description = "Managed Identity ID for encryption"

  default = ""

  validation {
    condition     = (var.encryption_user_managed_identity == "" ? true : (var.infra_type == "azure" ? true : false))
    error_message = "encryption_user_managed_identity can only be set when 'infra_type' is set to 'azure'."
  }
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

variable "use_public_ips" {
  type = bool

  description = "Use public ip's for the CDP resources created within the Cloud network. Required for CDP deployment on Azure and GCP."

  default = null
}

# ------- Cloud Service Provider Settings - AWS specific -------

variable "aws_vpc_id" {
  type        = string
  description = "AWS Virtual Private Network ID. Required for CDP deployment on AWS."

  default = null

  validation {
    condition     = (var.infra_type == "aws" && var.aws_vpc_id == null) ? false : true
    error_message = "aws_vpc_id must be set when 'infra_type' is 'aws'."
  }

}

variable "aws_public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet ids. Required for CDP deployment on AWS."

  default = null

  # validation {
  #   condition     = (var.infra_type == "aws" && (var.aws_public_subnet_ids == null || var.aws_private_subnet_ids == null )) ? false : true
  #   error_message = "aws_public_subnet_ids and/or aws_private_subnet_ids must be set when 'infra_type' is 'aws'."
  # }  
}

variable "aws_private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet ids. Required for CDP deployment on AWS."

  default = null

  #   validation {
  #   condition     = (var.infra_type == "aws" && (var.aws_public_subnet_ids == null || var.aws_private_subnet_ids == null )) ? false : true
  #   error_message = "aws_public_subnet_ids and/or aws_private_subnet_ids must be set when 'infra_type' is 'aws'."
  # }  
}

variable "aws_security_group_default_id" {
  type = string

  description = "ID of the Default Security Group for CDP environment. Required for CDP deployment on AWS."

  default = null

  validation {
    condition     = (var.infra_type == "aws" && var.aws_security_group_default_id == null) ? false : true
    error_message = "aws_security_group_default_id must be set when 'infra_type' is 'aws'."
  }
}

variable "aws_security_group_knox_id" {
  type = string

  description = "ID of the Knox Security Group for CDP environment. Required for CDP deployment on AWS."

  default = null

  validation {
    condition     = (var.infra_type == "aws" && var.aws_security_group_knox_id == null) ? false : true
    error_message = "aws_security_group_knox_id must be set when 'infra_type' is 'aws'."
  }
}

variable "aws_security_access_cidr" {
  type = string

  description = "CIDR range for inbound traffic. With this option security groups will be automatically created. Only used for CDP deployment on AWS. Note it is recommended to specify pre-existing security groups instead of this option."

  default = null
}

variable "aws_datalake_admin_role_arn" {
  type = string

  description = "Datalake Admin Role ARN. Required for CDP deployment on AWS."

  default = null

  validation {
    condition     = (var.infra_type == "aws" && var.aws_datalake_admin_role_arn == null) ? false : true
    error_message = "aws_datalake_admin_role_arn must be set when 'infra_type' is 'aws'."
  }

}

variable "aws_ranger_audit_role_arn" {
  type = string

  description = "Ranger Audit Role ARN. Required for CDP deployment on AWS."

  default = null

  validation {
    condition     = (var.infra_type == "aws" && var.aws_ranger_audit_role_arn == null) ? false : true
    error_message = "aws_ranger_audit_role_arn must be set when 'infra_type' is 'aws'."
  }
}

variable "aws_xaccount_role_arn" {
  type = string

  description = "Cross Account Role ARN. Required for CDP deployment on AWS."

  default = null

  validation {
    condition     = (var.infra_type == "aws" && var.aws_xaccount_role_arn == null) ? false : true
    error_message = "aws_xaccount_role_arn must be set when 'infra_type' is 'aws'."
  }

}

variable "aws_log_instance_profile_arn" {
  type = string

  description = "Log Instance Profile ARN. Required for CDP deployment on AWS."

  default = null

  validation {
    condition     = (var.infra_type == "aws" && var.aws_log_instance_profile_arn == null) ? false : true
    error_message = "aws_log_instance_profile_arn must be set when 'infra_type' is 'aws'."
  }
}

variable "aws_idbroker_instance_profile_arn" {
  type = string

  description = "IDBroker Instance Profile ARN. Required for CDP deployment on AWS."

  default = null

  validation {
    condition     = (var.infra_type == "aws" && var.aws_idbroker_instance_profile_arn == null) ? false : true
    error_message = "aws_idbroker_instance_profile_arn must be set when 'infra_type' is 'aws'."
  }
}

variable "aws_raz_role_arn" {
  type = string

  description = "ARN for Ranger Authorization Service (RAZ) role. Only applicable for CDP deployment on AWS."

  default = null

  validation {
    condition     = (var.infra_type == "aws" && var.enable_raz == true && var.aws_raz_role_arn == null) ? false : true
    error_message = "aws_raz_role_arn must be set when 'infra_type' is 'aws' and RAZ is enabled."
  }
}

# ------- Cloud Service Provider Settings - Azure specific -------
variable "azure_subscription_id" {
  type = string

  description = "Subscription ID where the Azure pre-reqs are created. Required for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.infra_type == "azure" && var.azure_subscription_id == null) ? false : true
    error_message = "azure_subscription_id must be set when 'infra_type' is 'azure'."
  }
}

variable "azure_tenant_id" {
  type = string

  description = "Tenant ID where the Azure pre-reqs are created. Required for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.infra_type == "azure" && var.azure_tenant_id == null) ? false : true
    error_message = "azure_tenant_id must be set when 'infra_type' is 'azure'."
  }
}

variable "azure_cdp_resource_group_name" {
  type        = string
  description = "Azure Resource Group name for CDP resources. Required for Cloudera on Azure deployment."

  default = null

  validation {
    condition     = (var.infra_type == "azure" && var.azure_cdp_resource_group_name == null) ? false : true
    error_message = "azure_cdp_resource_group_name must be set when 'infra_type' is 'azure'."
  }
}

variable "azure_network_resource_group_name" {
  type        = string
  description = "Azure Resource Group name for Network resources. Required for Cloudera on Azure deployment."

  default = null

  validation {
    condition     = (var.infra_type == "azure" && var.azure_network_resource_group_name == null) ? false : true
    error_message = "azure_network_resource_group_name must be set when 'infra_type' is 'azure'."
  }
}

variable "azure_vnet_name" {
  type        = string
  description = "Azure Virtual Network ID. Required for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.infra_type == "azure" && var.azure_vnet_name == null) ? false : true
    error_message = "azure_vnet_name must be set when 'infra_type' is 'azure'."
  }
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

variable "azure_create_private_endpoints" {
  type        = bool
  description = "Flag to specify that Azure Postgres will be configured with Private Endpoint and a Private DNS Zone."

  default = null
}

variable "azure_accept_image_terms" {
  type        = bool
  description = "Flag to automatically accept Azure Marketplace image terms during CDP cluster deployment."

  default = true
}

variable "azure_cdp_subnet_names" {
  type        = list(any)
  description = "List of Azure Subnet Names for CDP Resources. Required for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.infra_type == "azure" && var.azure_cdp_subnet_names == null) ? false : true
    error_message = "azure_cdp_subnet_names must be set when 'infra_type' is 'azure'."
  }
}

variable "azure_cdp_gateway_subnet_names" {
  type        = list(any)
  description = "List of Azure Subnet Names CDP Endpoint Access Gateway. Required for CDP deployment on Azure."

  default = null

}

variable "azure_environment_flexible_server_delegated_subnet_names" {
  type        = list(any)
  description = "List of Azure Subnet Names delegated for Private Flexible servers. Required for CDP deployment on Azure."

  default = null

}

variable "azure_security_group_default_uri" {
  type        = string
  description = "Azure Default Security Group URI. Required for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.infra_type == "azure" && var.azure_security_group_default_uri == null) ? false : true
    error_message = "azure_security_group_default_uri must be set when 'infra_type' is 'azure'."
  }
}

variable "azure_security_group_knox_uri" {
  type        = string
  description = "Azure Knox Security Group URI. Required for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.infra_type == "azure" && var.azure_security_group_knox_uri == null) ? false : true
    error_message = "azure_security_group_knox_uri must be set when 'infra_type' is 'azure'."
  }
}

variable "azure_security_access_cidr" {
  type = string

  description = "CIDR range for inbound traffic. With this option security groups will be automatically created. Only used for CDP deployment on Azure. Note it is recommended to specify pre-existing security groups instead of this option."

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

  validation {
    condition     = (var.infra_type == "azure" && var.azure_idbroker_identity_id == null) ? false : true
    error_message = "azure_idbroker_identity_id must be set when 'infra_type' is 'azure'."
  }
}

variable "azure_datalakeadmin_identity_id" {
  type = string

  description = "Datalake Admin Managed Identity ID. Required for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.infra_type == "azure" && var.azure_datalakeadmin_identity_id == null) ? false : true
    error_message = "azure_datalakeadmin_identity_id must be set when 'infra_type' is 'azure'."
  }

}

variable "azure_ranger_audit_identity_id" {
  type = string

  description = "Ranger Audit Managed Identity ID. Required for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.infra_type == "azure" && var.azure_ranger_audit_identity_id == null) ? false : true
    error_message = "azure_ranger_audit_identity_id must be set when 'infra_type' is 'azure'."
  }
}

variable "azure_log_identity_id" {
  type = string

  description = "Log Data Access Managed Identity ID. Required for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.infra_type == "azure" && var.azure_log_identity_id == null) ? false : true
    error_message = "azure_log_identity_id must be set when 'infra_type' is 'azure'."
  }

}

variable "azure_raz_identity_id" {
  type = string

  description = "RAZ Managed Identity ID. Required for CDP deployment on Azure."

  default = null

  validation {
    condition     = (var.infra_type == "azure" && var.enable_raz == true && var.azure_raz_identity_id == null) ? false : true
    error_message = "azure_raz_identity_id must be set when 'infra_type' is 'azure' and RAZ is enabled."
  }

}

variable "azure_datalake_flexible_server_delegated_subnet_name" {
  type = string

  description = "The subnet ID for the subnet within which you want to configure your Azure Flexible Server for the CDP datalake"

  default = null
}

variable "azure_load_balancer_sku" {
  type = string

  description = "The Azure load balancer SKU type. Possible values are BASIC, STANDARD or None. The current default is BASIC. To disable the load balancer, use type NONE."

  default = null
}

# ------- Cloud Service Provider Settings - GCP specific -------

variable "gcp_project_id" {
  type = string

  description = "GCP project to deploy CDP environment. Required for CDP deployment on GCP."

  default = null

  validation {
    condition     = (var.infra_type == "gcp" && var.gcp_project_id == null) ? false : true
    error_message = "gcp_project_id must be set when 'infra_type' is 'gcp'."
  }
}

variable "gcp_xaccount_service_account_private_key" {
  type = string

  description = "Base64 encoded private key of the GCP Cross Account Service Account Key. Required for CDP deployment on GCP."

  default = null

  validation {
    condition     = (var.infra_type == "gcp" && var.gcp_xaccount_service_account_private_key == null) ? false : true
    error_message = "gcp_xaccount_service_account_private_key must be set when 'infra_type' is 'gcp'."
  }
}

variable "gcp_network_name" {
  type        = string
  description = "GCP Network VPC name. Required for CDP deployment on GCP."

  default = null

  validation {
    condition     = (var.infra_type == "gcp" && var.gcp_network_name == null) ? false : true
    error_message = "gcp_network_name must be set when 'infra_type' is 'gcp'."
  }

}

variable "gcp_cdp_subnet_names" {
  type        = list(any)
  description = "List of GCP Subnet Names for CDP Resources. Required for CDP deployment on GCP."

  default = null

  validation {
    condition     = (var.infra_type == "gcp" && var.gcp_cdp_subnet_names == null) ? false : true
    error_message = "gcp_cdp_subnet_names must be set when 'infra_type' is 'gcp'."
  }
}

variable "gcp_availability_zones" {
  type = list(string)

  description = "The zones of the environment in the given region. Multi-zone selection is not supported in GCP yet. It accepts only one zone until support is added."

  default = null
}

variable "gcp_firewall_default_id" {
  type        = string
  description = "Default Firewall for CDP environment.  Required for CDP deployment on GCP."

  default = null

  validation {
    condition     = (var.infra_type == "gcp" && var.gcp_firewall_default_id == null) ? false : true
    error_message = "gcp_firewall_default_id must be set when 'infra_type' is 'gcp'."
  }
}

variable "gcp_firewall_knox_id" {
  type        = string
  description = "Knox Firewall for CDP environment. Required for CDP deployment on GCP."

  default = null

  validation {
    condition     = (var.infra_type == "gcp" && var.gcp_firewall_knox_id == null) ? false : true
    error_message = "gcp_firewall_knox_id must be set when 'infra_type' is 'gcp'."
  }

}

variable "gcp_idbroker_service_account_email" {
  type = string

  description = "Email id of the service account for IDBroker. Required for CDP deployment on GCP."

  default = null

  validation {
    condition     = (var.infra_type == "gcp" && var.gcp_idbroker_service_account_email == null) ? false : true
    error_message = "gcp_idbroker_service_account_email must be set when 'infra_type' is 'gcp'."
  }
}

variable "gcp_log_service_account_email" {
  type = string

  description = "Email id of the service account for Log Storage. Required for CDP deployment on GCP."

  default = null

  validation {
    condition     = (var.infra_type == "gcp" && var.gcp_log_service_account_email == null) ? false : true
    error_message = "gcp_log_service_account_email must be set when 'infra_type' is 'gcp'."
  }
}

variable "gcp_ranger_audit_service_account_email" {
  type = string

  description = "Email id of the service account for Ranger Audit. Required for CDP deployment on GCP."

  default = null

  validation {
    condition     = (var.infra_type == "gcp" && var.gcp_ranger_audit_service_account_email == null) ? false : true
    error_message = "gcp_ranger_audit_service_account_email must be set when 'infra_type' is 'gcp'."
  }

}

variable "gcp_datalake_admin_service_account_email" {
  type = string

  description = "Email id of the service account for Datalake Admin. Required for CDP deployment on GCP."

  default = null

  validation {
    condition     = (var.infra_type == "gcp" && var.gcp_datalake_admin_service_account_email == null) ? false : true
    error_message = "gcp_datalake_admin_service_account_email must be set when 'infra_type' is 'gcp'."
  }
}

variable "gcp_encryption_key" {
  type = string

  description = "Key Resource ID of the customer managed encryption key to encrypt GCP resources. Only applicable for CDP deployment on GCP."

  default = null

}

variable "gcp_raz_service_account_email" {
  type = string

  description = "Email id of the service account for Ranger Authorization Service (RAZ). Only applicable for CDP deployment on GCP."

  default = null

  validation {
    condition     = (var.infra_type == "gcp" && var.enable_raz == true && var.gcp_raz_service_account_email == null) ? false : true
    error_message = "gcp_raz_service_account_email must be set when 'infra_type' is 'gcp' and RAZ is enabled."
  }

}
