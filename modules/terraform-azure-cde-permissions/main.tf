# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_cde" {

  location            = var.azure_region
  name                = var.azure_cde_managed_identity_name
  resource_group_name = var.azure_resource_group_name

  tags = merge(var.tags, { Name = var.azure_cde_managed_identity_name })
}

# Assign the required roles to the CDE managed identity
resource "azurerm_role_assignment" "cdp_cde_container_assign" {

  for_each = {
    for idx, role in var.cde_container_role_assignments : idx => role
  }

  scope                = data.azurerm_storage_container.log_storage_container.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_cde.principal_id

  description = each.value.description
}
