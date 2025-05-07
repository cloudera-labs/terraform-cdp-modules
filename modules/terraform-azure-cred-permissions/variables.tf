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

# Cross Account Application
variable "xaccount_app_name" {
  type = string

  description = "Cross account application name within Azure Active Directory"

  default = null

  validation {
    condition     = (var.xaccount_app_name == null && var.existing_xaccount_app_client_id == null) ? false : true
    error_message = "xaccount_app_name must be be set when 'existing_xaccount_app_client_id' is not specified."
  }
}

variable "azure_subscription_id" {
  type = string

  description = "Azure Subscription ID"

  default = null

  validation {
    condition     = (var.azure_subscription_id == null && var.existing_xaccount_app_client_id == null) ? false : true
    error_message = "azure_subscription_id must be be set when 'existing_xaccount_app_client_id' is not specified."
  }
}

variable "xaccount_app_owners" {
  type = list(string)

  description = "List principals object IDs that will be granted ownership of the Cross Account application. If not specified the executing principal will be set as the owner."

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

variable "xaccount_app_password_end_date_relative" {
  type = string

  default = "17520h" #expire in 2 years
}

# ------- Support for existing Cross Account Role -------
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