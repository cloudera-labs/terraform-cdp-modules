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

locals {

  # CML Backup Policy document
  cml_backup_policy_doc = coalesce(var.cml_backup_policy_doc, data.http.cml_backup_policy_doc.response_body)

  # CML Backup Policy document
  cml_restore_policy_doc = coalesce(var.cml_restore_policy_doc, data.http.cml_restore_policy_doc.response_body)

}