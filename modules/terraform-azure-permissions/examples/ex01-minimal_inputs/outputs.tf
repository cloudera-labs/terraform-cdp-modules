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

output "azure_idbroker_identity_id" {
  value = module.ex01_azure_permissions.azure_idbroker_identity_id

  description = "IDBroker Managed Identity ID"
}

output "azure_datalakeadmin_identity_id" {
  value = module.ex01_azure_permissions.azure_datalakeadmin_identity_id

  description = "Datalake Admin Managed Identity ID"
}

output "azure_log_identity_id" {
  value       = module.ex01_azure_permissions.azure_log_identity_id
  description = "Log Data Access Managed Identity ID"
}

output "azure_ranger_audit_identity_id" {
  value = module.ex01_azure_permissions.azure_ranger_audit_identity_id

  description = "Ranger Audit Managed Identity ID"
}

output "azure_raz_identity_id" {
  value = module.ex01_azure_permissions.azure_raz_identity_id

  description = "RAZ Managed Identity ID. Value returned if RAZ is enabled"
}
