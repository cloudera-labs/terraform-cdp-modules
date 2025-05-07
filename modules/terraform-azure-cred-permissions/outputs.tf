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

output "azure_xaccount_app_client_id" {
  value = local.create_xaccount_resources ? azuread_application.cdp_xaccount_app[0].client_id : data.azuread_application.existing_xaccount_app[0].client_id

  description = "Client ID for the Azure AD Cross Account Application"

}

output "azure_xaccount_app" {
  value = local.create_xaccount_resources ? azuread_application.cdp_xaccount_app[0] : data.azuread_application.existing_xaccount_app[0]

  description = "Full details for the Azure AD Cross Account Application"

}

output "azure_xaccount_app_pword" {
  value = local.create_xaccount_resources ? azuread_application_password.cdp_xaccount_app_password[0].value : var.existing_xaccount_app_pword

  description = "Password for the Azure AD Cross Account Application"

  sensitive = true
}

output "azure_xaccount_service_principal_id" {
  value = try(azuread_service_principal.cdp_xaccount_app_sp[0].id, null)

  description = "ID for the Azure AD Cross Account Service Principal"

}