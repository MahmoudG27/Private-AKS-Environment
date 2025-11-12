# Azure Container Registry
resource "azurerm_container_registry" "rabbit_acr" {
  name                          = var.acr_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.acr_sku
  admin_enabled                 = true
  public_network_access_enabled = false
}

resource "azurerm_role_assignment" "Attach-ACR" {
  principal_id                     = var.aks_identity_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.rabbit_acr.id
  skip_service_principal_aad_check = true
}