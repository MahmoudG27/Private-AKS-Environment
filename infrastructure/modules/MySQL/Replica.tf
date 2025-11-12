# Replica MySQL Server
resource "azurerm_mysql_flexible_server" "mysql_replica_server" {
  count = var.environment == "prod" ? 1 : 0
  name                = var.mysql_replica_name
  resource_group_name = var.resource_group_name
  location            = var.location
  zone                = "3"
  create_mode         = "Replica"
  source_server_id    = azurerm_mysql_flexible_server.mysql_server.id
}