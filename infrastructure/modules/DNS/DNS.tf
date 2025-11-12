resource "azurerm_dns_zone" "rabbit_dns" {
  name                = "rabbit.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "dns_aks" {
  principal_id                     = var.aks_identity_id
  role_definition_name             = "Contributor"
  scope                            = azurerm_dns_zone.rabbit_dns.id
  skip_service_principal_aad_check = true
}