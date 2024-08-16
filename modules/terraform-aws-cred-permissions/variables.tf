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
}

# ------- Support for existing Cross Account Role -------
variable "existing_xaccount_role_name" {
  type        = string
  description = "Name of existing CDP Cross Account Role. If set then no policy or role resources are created."

  default = null
}
