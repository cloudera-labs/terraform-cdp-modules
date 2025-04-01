# Copyright 2024 Cloudera, Inc. All Rights Reserved.
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

variable "tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

  default = null
}

# ------- Azure specific settings -------
variable "azure_resource_group_name" {
  type        = string
  description = "Azrue Resource Group for CDP environment."

}

variable "azure_aks_credential_managed_identity_name" {
  type = string

  description = "Name of the Managed Identity for the AKS Credential"

  validation {
    condition     = length(var.azure_aks_credential_managed_identity_name) <= 128
    error_message = "The length of azure_aks_credential_managed_identity_name must be 128 characters or less."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]{1,128}$", var.azure_aks_credential_managed_identity_name))
    error_message = "azure_aks_credential_managed_identity_name can consist only of letters, numbers, hyphens (-) and underscores (_)."
  }
}

variable "azure_data_storage_account" {
  type = string

  description = "Name of the Azure Storage Account used for CDP Data"

}

variable "cdw_aks_cred_subscription_role_assignments" {
  type = list(object({
    role        = string
    description = optional(string)
    })
  )

  description = "List of Role Assignments for the AKS Credential at subscription scope"

  default = [
    {
      "description" : "Assign Contributor Role to AKS Credential",
      "role" : "Contributor"
    }
  ]

}

variable "cdw_aks_cred_storage_role_assignments" {
  type = list(object({
    role        = string
    description = optional(string)
    })
  )

  description = "List of Role Assignments for the AKS Credential at Data Storage Account scope."

  default = [
    {
      "description" : "Assign Storage Blob Data Owner assignment to CDP Data Storage Container to AKS Credential",
      "role" : "Storage Blob Data Owner"
    }
  ]

}
