# Required to create internal Load Balancer for Nginx Ingress Controller
resource "azurerm_role_assignment" "network-contributor" {
  scope                = var.aks_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
}