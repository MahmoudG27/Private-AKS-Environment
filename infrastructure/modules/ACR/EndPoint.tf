# Create Private EndPoint For ACR
resource "azurerm_private_endpoint" "acr_private_endpoint" {
  name                = "demo-acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.acr_subnet_id

  private_service_connection {
    is_manual_connection           = false
    name                           = "acr-endpoint-connection"
    private_connection_resource_id = azurerm_container_registry.rabbit_acr.id
    subresource_names              = ["registry"]
  }

  private_dns_zone_group {
    name = "private-dns-zone-group"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.acr_private_dns_zone.id
    ]
  }
}
