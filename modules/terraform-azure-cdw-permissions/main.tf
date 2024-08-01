# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_cdw_aks_cred" {

  location            = var.azure_region
  name                = var.azure_aks_credential_managed_identity_name
  resource_group_name = var.azure_resource_group_name

  tags = merge(var.tags, { Name = var.azure_aks_credential_managed_identity_name })
}

# Assign the required roles to the AKS credential managed identity
resource "azurerm_role_assignment" "cdp_cdw_aks_cred_subscription_assign" {

  for_each = {
    for idx, role in var.cdw_aks_cred_subscription_role_assignments : idx => role
  }

  scope                = data.azurerm_subscription.current.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_cdw_aks_cred.principal_id

  description = each.value.description
}

resource "azurerm_role_assignment" "cdp_cdw_aks_cred_storage_assign" {

  for_each = {
    for idx, role in var.cdw_aks_cred_storage_role_assignments : idx => role
  }

  scope                = data.azurerm_storage_account.data_storage_account.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_cdw_aks_cred.principal_id

  description = each.value.description
}
