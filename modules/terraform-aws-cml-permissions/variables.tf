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
variable "tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

  default = null
}

# ------- IAM Policy details -------
variable "cml_backup_policy_name" {
  type = string

  description = "CDP CML Backup Policy name"

  validation {
    condition     = length(var.cml_backup_policy_name) <= 128
    error_message = "The length of cml_backup_policy_name must be 128 characters or less."
  }
}

variable "cml_restore_policy_name" {
  type = string

  description = "CDP CML Restore Policy name"

  validation {
    condition     = length(var.cml_restore_policy_name) <= 128
    error_message = "The length of cml_restore_policy_name must be 128 characters or less."
  }

}

variable "cml_backup_policy_doc" {
  type = string

  description = "Contents of CDP CML Backup Policy Document. If not specified document is downloaded from Cloudera Document repository"

  default = null
}

variable "cml_restore_policy_doc" {
  type = string

  description = "Contents of CDP CML Restore Policy Document. If not specified document is downloaded from Cloudera Document repository"

  default = null
}

# ------- Cross Account Roles -------
variable "xaccount_role_name" {
  type        = string
  description = "Name of existing cross account Assume role Name."

}
