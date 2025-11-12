resource "azurerm_subnet" "infra_subnet" {
  name                 = var.infra_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.project-vnet.name
  address_prefixes     = [var.infra_subnet_address]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.project-vnet.name
  address_prefixes     = [var.aks_subnet_address]

  depends_on = [azurerm_subnet.infra_subnet]
}

resource "azurerm_subnet" "db_subnet" {
  name                 = var.db_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.project-vnet.name
  address_prefixes     = [var.db_subnet_address]

  depends_on = [azurerm_subnet.aks_subnet]

  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }

}

resource "azurerm_subnet" "vpn_subnet" {
  name                 = var.vpn_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.project-vnet.name
  address_prefixes     = [var.vpn_subnet_address]

  depends_on = [azurerm_subnet.db_subnet]
}

resource "azurerm_subnet" "nat_subnet" {
  name                 = var.nat_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.project-vnet.name
  address_prefixes     = [var.nat_subnet_address]

  depends_on = [azurerm_subnet.vpn_subnet]
}