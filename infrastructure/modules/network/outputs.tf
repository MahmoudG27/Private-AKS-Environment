# Virtual Network Outputs
output "virtual_network_name" {
  value = azurerm_virtual_network.project-vnet.name
}
output "virtual_network_id" {
  value = azurerm_virtual_network.project-vnet.id
}

# Infrastructure Subnet id
output "infra_subnet_id" {
  value = azurerm_subnet.infra_subnet.id
}

# AKS Cluster Subnet id
output "aks_subnet_id" {
  value = azurerm_subnet.aks_subnet.id
}

# DB Subnet id
output "db_subnet_id" {
  value = azurerm_subnet.db_subnet.id
}

# VPN Subnet id
output "vpn_subnet_id" {
  value = azurerm_subnet.vpn_subnet.id
}

# NAT Subnet id
output "nat_subnet_id" {
  value = azurerm_subnet.nat_subnet.id
}