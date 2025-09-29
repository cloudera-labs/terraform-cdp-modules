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

locals {

  # ------- Determine if resources should be created -------
  raz_data_storage_role_assignments = (
    var.enable_raz && var.data_storage_account_id != null
    ? { for idx, item in var.raz_storage_role_assignments : idx => item }
    : {}
  )

  raz_log_storage_role_assignments = (
    var.enable_raz && var.log_storage_account_id != null
    ? { for idx, item in var.raz_storage_role_assignments : idx => item }
    : {}
  )

  raz_backup_storage_role_assignments = (
    var.enable_raz && var.backup_storage_account_id != null
    ? { for idx, item in var.raz_storage_role_assignments : idx => item }
    : {}
  )

}

