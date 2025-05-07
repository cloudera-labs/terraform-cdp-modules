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

# Create Azure AD Application
resource "azuread_application" "cdp_xaccount_app" {

  count = local.create_xaccount_resources ? 1 : 0

  display_name = var.xaccount_app_name

  owners = local.xaccount_app_owners
}

# Create Service Principal associated with the Azure AD App
resource "azuread_service_principal" "cdp_xaccount_app_sp" {

  count = local.create_xaccount_resources ? 1 : 0

  client_id = azuread_application.cdp_xaccount_app[0].client_id

  owners = local.xaccount_app_owners
}

# Create role assignment for Service Principal
resource "azurerm_role_assignment" "cdp_xaccount_role" {

  for_each = { for idx, role in var.xaccount_app_role_assignments : idx => role
  if local.create_xaccount_resources }

  scope                = coalesce(each.value.scope, data.azurerm_subscription.sub_details[0].id)
  role_definition_name = each.value.role
  principal_id         = azuread_service_principal.cdp_xaccount_app_sp[0].id

  description = each.value.description
}

# Create Application password (client secret)
resource "azuread_application_password" "cdp_xaccount_app_password" {

  count = local.create_xaccount_resources ? 1 : 0

  application_id    = azuread_application.cdp_xaccount_app[0].id
  end_date_relative = var.xaccount_app_password_end_date_relative
}
