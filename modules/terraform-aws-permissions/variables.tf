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

variable "process_policy_placeholders" {
  type        = bool
  description = "Flag to enable replacement of the standard placeholders in the AWS CDP Policy documents"

  default = true
}

variable "arn_partition" {
  type        = string
  description = "The string used to subsitute ARN_PARTITION placeholder in policy documents."

  default = "aws"

}

# ------- Policies -------
# CDP IDBroker Assume Role policy
variable "idbroker_policy_name" {
  type        = string
  description = "IDBroker Policy name"

  validation {
    condition     = length(var.idbroker_policy_name) <= 128
    error_message = "The length of idbroker_policy_name must be 128 characters or less."
  }
}

variable "idbroker_policy_doc" {
  type        = string
  description = "Contents of IDBroker Assumer Policy Document."
}

# CDP Data Access Policies - Log
variable "log_data_access_policy_name" {
  type        = string
  description = "Log Data Access Policy Name"

  validation {
    condition     = length(var.log_data_access_policy_name) <= 128
    error_message = "The length of log_data_access_policy_name must be 128 characters or less."
  }

}

variable "log_data_access_policy_doc" {
  type        = string
  description = "Contents of Log Data Access Policy"

}

# CDP Data Access Policies - ranger_audit_s3
variable "ranger_audit_s3_policy_name" {
  type        = string
  description = "Ranger S3 Audit Data Access Policy Name"

  validation {
    condition     = length(var.ranger_audit_s3_policy_name) <= 128
    error_message = "The length of ranger_audit_s3_policy_name must be 128 characters or less."
  }
}

variable "ranger_audit_s3_policy_doc" {
  type        = string
  description = "Contents of Ranger S3 Audit Data Access Policy"
}

# CDP Data Access Policies - datalake_admin_s3 
variable "datalake_admin_s3_policy_name" {
  type        = string
  description = "Datalake Admin S3 Data Access Policy Name"

  validation {
    condition     = length(var.datalake_admin_s3_policy_name) <= 128
    error_message = "The length of datalake_admin_s3_policy_name must be 128 characters or less."
  }

}

variable "datalake_admin_s3_policy_doc" {
  type        = string
  description = "Contents of Datalake Admin S3 Data Access Policy"

}

variable "datalake_backup_policy_doc" {
  type        = string
  description = "Contents of Datalake Backup Data Access Policy"

}

variable "datalake_restore_policy_doc" {
  type        = string
  description = "Contents of Datalake Restore Data Access Policy"

  default = null
}

# CDP Data Access Policies - bucket_access
variable "data_bucket_access_policy_name" {
  type        = string
  description = "Data Bucket Access Data Access Policy Name"

  validation {
    condition     = length(var.data_bucket_access_policy_name) <= 128
    error_message = "The length of data_bucket_access_policy_name must be 128 characters or less."
  }

}
variable "log_bucket_access_policy_name" {
  type        = string
  description = "Log Bucket Access Data Access Policy Name"

  validation {
    condition     = length(var.log_bucket_access_policy_name) <= 128
    error_message = "The length of log_bucket_access_policy_name must be 128 characters or less."
  }
}

variable "backup_bucket_access_policy_name" {
  type        = string
  description = "Backup Bucket Access Data Access Policy Name"

  validation {
    condition     = length(var.backup_bucket_access_policy_name) <= 128
    error_message = "The length of backup_bucket_access_policy_name must be 128 characters or less."
  }
}

# CDP Datalake restore Policies - datalake
variable "datalake_restore_policy_name" {
  type        = string
  description = "Datalake restore Data Access Policy Name"

  default = null

  validation {
    condition     = length(var.datalake_restore_policy_name) <= 128
    error_message = "The length of datalake_restore_policy_name must be 128 characters or less."
  }
}

# CDP Datalake backup Policies - datalake
variable "datalake_backup_policy_name" {
  type        = string
  description = "Datalake backup Data Access Policy Name"

  validation {
    condition     = length(var.datalake_backup_policy_name) <= 128
    error_message = "The length of datalake_backup_policy_name must be 128 characters or less."
  }
}

variable "data_bucket_access_policy_doc" {
  type        = string
  description = "Data Bucket Access Data Access Policy"

}

variable "log_bucket_access_policy_doc" {
  type        = string
  description = "Contents of Log Bucket Access Data Access Policy"

}
variable "backup_bucket_access_policy_doc" {
  type        = string
  description = "Contents of Backup Bucket Access Data Access Policy"

}

# ------- Roles -------
# IDBroker service role
variable "idbroker_role_name" {
  type        = string
  description = "IDBroker service role Name"

  validation {
    condition     = length(var.idbroker_role_name) <= 64
    error_message = "The length of idbroker_role_name must be 64 characters or less."
  }
}

# Log service role
variable "log_role_name" {
  type        = string
  description = "Log service role Name"

  validation {
    condition     = length(var.log_role_name) <= 64
    error_message = "The length of log_role_name must be 64 characters or less."
  }
}

# CDP Datalake Admin role
variable "datalake_admin_role_name" {
  type        = string
  description = "Datalake Admin role Name"

  validation {
    condition     = length(var.datalake_admin_role_name) <= 64
    error_message = "The length of datalake_admin_role_name must be 64 characters or less."
  }
}

# CDP Ranger Audit role
variable "ranger_audit_role_name" {
  type        = string
  description = "Ranger Audit role Name"

  validation {
    condition     = length(var.ranger_audit_role_name) <= 64
    error_message = "The length of ranger_audit_role_name must be 64 characters or less."
  }
}

# ------- Buckets and Storage Locations -------
variable "data_storage_bucket" {
  type = string

  description = "Name of the Data storage bucket"
}

variable "log_storage_bucket" {
  type = string

  description = "Name of the Log storage bucket"
}

variable "backup_storage_bucket" {
  type = string

  description = "Name of the Backup storage bucket"
}

variable "storage_location_base" {
  type = string

  description = "The bucket and path to the Data Lake storage directory. Should be specified as <data_storage_bucket>/<some_path>"

  default = null
}

variable "log_location_base" {
  type = string

  description = "The bucket and path to the location for log storage. Should be specified as <log_storage_bucket>/<some_path>"

  default = null
}

variable "backup_location_base" {
  type = string

  description = "The bucket and path to the location used for FreeIPA and Datalake backups. Should be specified as <backup_storage_bucket>/<some_path>"

  default = null
}