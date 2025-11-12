resource "azurerm_cdn_frontdoor_endpoint" "endpoint_aks_ingress" {
  name                     = var.frontdoor_endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor.id
}

resource "azurerm_cdn_frontdoor_origin_group" "origin_group_aks_ingress" {
  name                     = var.origin_group_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor.id
  session_affinity_enabled = true

  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
  }

  health_probe {
    request_type        = "HEAD"
    protocol            = "Http"
    interval_in_seconds = 100
  }
}

resource "azurerm_cdn_frontdoor_origin" "origin_aks_ingress" {
  name                          = var.origin_name
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.origin_group_aks_ingress.id

  enabled                        = true
  host_name                      = "10.224.0.50" # Internal IP of the Load Balancer in front of the AKS Ingress
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = "10.224.0.50" # Must match the host name used in the TLS certificate on the AKS Ingress
  priority                       = 1
  weight                         = 1000
  certificate_name_check_enabled = true

  # private_link {
  #   private_link_target_id = data.azurerm_private_link_service.pls_ingress.id
  #   request_message        = "Request access for Azure Front Door Private Link origin"
  #   location               = var.location
  #   # target_type            = "privateLinkServices" # cannot be specified when using a Load Balancer as an Origin.
  # }
}

resource "azurerm_cdn_frontdoor_route" "route-aks-ingress" {
  name                          = "route-aks-ingress"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.endpoint_aks_ingress.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.origin_group_aks_ingress.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.origin_aks_ingress.id]
  supported_protocols           = ["Http", "Https"]
  patterns_to_match             = ["/*"]
  forwarding_protocol           = "HttpOnly" # "HttpsOnly" , "MatchRequest"
  link_to_default_domain        = true
  https_redirect_enabled        = true
  cdn_frontdoor_origin_path     = "/"
}