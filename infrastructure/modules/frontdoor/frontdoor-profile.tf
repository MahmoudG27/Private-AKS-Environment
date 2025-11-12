resource "azurerm_cdn_frontdoor_profile" "frontdoor" {
  name                = var.frontdoor_name
  resource_group_name = var.resource_group_name
  sku_name            = "Premium_AzureFrontDoor" # Must be premium for Private Link support.
}