resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = "nat-gateway"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"] # Only one AZ can be defined.
}

resource "azurerm_subnet_nat_gateway_association" "association" {
  subnet_id      = var.aks_subnet_id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}