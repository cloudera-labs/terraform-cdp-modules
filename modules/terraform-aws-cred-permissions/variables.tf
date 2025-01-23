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
variable "tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

  default = null
}

# ------- CDP Settings -------
variable "xaccount_account_id" {
  type        = string
  description = "Account ID of the cross account. Required if xaccount resources are to be created."

  default = null
}

variable "xaccount_external_id" {
  type        = string
  description = "External ID of the cross account. Required if xaccount resources are to be created."

  default = null

}

# ------- Policies -------
variable "xaccount_policy_name" {
  type        = string
  description = "Cross Account Policy name. Required if xaccount resources are to be created."

  default = null

  validation {
    condition     = (var.xaccount_policy_name == null ? true : length(var.xaccount_policy_name) <= 128)
    error_message = "The length of xaccount_policy_name must be 128 characters or less."
  }

}

variable "xaccount_account_policy_doc" {
  type        = string
  description = "Contents of cross acount policy document. Required if xaccount resources are to be created."

  default = null
}

# ------- Roles -------
variable "xaccount_role_name" {
  type        = string
  description = "Cross account Assume role Name. Required if xaccount resources are to be created."

  default = null

  validation {
    condition     = (var.xaccount_role_name == null ? true : length(var.xaccount_role_name) <= 64)
    error_message = "The length of xaccount_role_name must be 64 characters or less."
  }

}

# ------- Support for existing Cross Account Role -------
variable "existing_xaccount_role_name" {
  type        = string
  description = "Name of existing CDP Cross Account Role. If set then no policy or role resources are created."

  default = null
}

# ------- Assume role policy for CML Backup and Restore -------
variable "create_cml_assume_role_policy" {
  type = bool

  description = "Add AWS Backup Service, required for CML Backup and Restore, to Cross Account Trust Relationship."

  default = false
}

