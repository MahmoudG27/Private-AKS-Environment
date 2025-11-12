module "ResourceGroup" {
  source                  = "../../modules/ResourceGroup"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location

  environment = var.environment
}

module "Network" {
  source                  = "../../modules/network"
  virtual_network_name    = var.virtual_network_name
  virtual_network_address = var.virtual_network_address
  infra_subnet_name       = var.infra_subnet_name
  infra_subnet_address    = var.infra_subnet_address
  aks_subnet_name         = var.aks_subnet_name
  aks_subnet_address      = var.aks_subnet_address
  db_subnet_name          = var.db_subnet_name
  db_subnet_address       = var.db_subnet_address
  vpn_subnet_name         = var.vpn_subnet_name
  vpn_subnet_address      = var.vpn_subnet_address
  nat_subnet_name         = var.nat_subnet_name
  nat_subnet_address      = var.nat_subnet_address

  environment = var.environment

  resource_group_name = module.ResourceGroup.resource_group_name
  location            = module.ResourceGroup.resource_group_location
}

module "ACR" {
  source   = "../../modules/ACR"
  acr_name = var.acr_name
  acr_sku  = var.acr_sku

  resource_group_name = module.ResourceGroup.resource_group_name
  location            = module.ResourceGroup.resource_group_location
  aks_identity_id     = module.AKS.aks_cluster_identity_id
  virtual_network_id  = module.Network.virtual_network_id
  acr_subnet_id       = module.Network.infra_subnet_id

  environment = var.environment
}

module "MySQL" {
  source              = "../../modules/MySQL"
  mysql_name          = var.mysql_name
  mysql_user          = var.mysql_user
  mysql_version       = var.mysql_version
  mysql_sku           = var.mysql_sku
  mysql_replica_name  = var.mysql_replica_name
  mysql_dns_zone_name = var.mysql_dns_zone_name

  resource_group_name = module.ResourceGroup.resource_group_name
  location            = module.ResourceGroup.resource_group_location
  virtual_network_id  = module.Network.virtual_network_id
  mysql_subnet_id     = module.Network.db_subnet_id

  environment = var.environment
}

module "VirtualMachine" {
  source                   = "../../modules/VM"
  agent_vm_name            = var.agent_vm_name
  agent_vm_size            = var.agent_vm_size
  agent_vm_admin_username  = var.agent_vm_admin_username
  agent_vm_os_disk_type    = var.agent_vm_os_disk_type
  agent_vm_os_disk_size_gb = var.agent_vm_os_disk_size_gb
  agent_vm_image_sku       = var.agent_vm_image_sku
  agent_private_ip         = var.agent_private_ip

  resource_group_name = module.ResourceGroup.resource_group_name
  location            = module.ResourceGroup.resource_group_location
  agent_subnet_id     = module.Network.infra_subnet_id

  environment = var.environment
}

module "VPN" {
  source             = "../../modules/VPN"
  vpn_public_ip_name = var.vpn_public_ip_name
  vpn_gateway_name   = var.vpn_gateway_name
  vpn_gateway_sku    = var.vpn_gateway_sku
  vpn_address_pool   = var.vpn_address_pool

  resource_group_name = module.ResourceGroup.resource_group_name
  location            = module.ResourceGroup.resource_group_location
  vpn_subnet_id       = module.Network.vpn_subnet_id

  environment = var.environment
}

module "NAT" {
  source             = "../../modules/NAT"
  nat_gateway_name   = var.nat_gateway_name
  nat_public_ip_name = var.nat_public_ip_name

  resource_group_name = module.ResourceGroup.resource_group_name
  location            = module.ResourceGroup.resource_group_location
  aks_subnet_id       = module.Network.aks_subnet_id

  environment = var.environment
}

module "AKS" {
  source           = "../../modules/AKS"
  aks_name         = var.aks_name
  aks_version      = var.aks_version
  aks_sku          = var.aks_sku
  aks_resources_rg = var.aks_resources_rg

  agent_pool_name           = var.agent_pool_name
  agent_pool_node_count     = var.agent_pool_node_count
  agent_pool_node_min_count = var.agent_pool_node_min_count
  agent_pool_node_max_count = var.agent_pool_node_max_count
  agent_pool_pods_node      = var.agent_pool_pods_node
  agent_pool_os_sku         = var.agent_pool_os_sku
  agent_pool_os_disk_type   = var.agent_pool_os_disk_type
  agent_pool_os_disk_size   = var.agent_pool_os_disk_size
  agent_pool_vm_size        = var.agent_pool_vm_size

  user_pool_name           = var.user_pool_name
  user_pool_node_count     = var.user_pool_node_count
  user_pool_node_min_count = var.user_pool_node_min_count
  user_pool_node_max_count = var.user_pool_node_max_count
  user_pool_pods_node      = var.user_pool_pods_node
  user_pool_os_sku         = var.user_pool_os_sku
  user_pool_os_disk_type   = var.user_pool_os_disk_type
  user_pool_os_disk_size   = var.user_pool_os_disk_size
  user_pool_vm_size        = var.user_pool_vm_size

  resource_group_name = module.ResourceGroup.resource_group_name
  location            = module.ResourceGroup.resource_group_location
  aks_subnet_id       = module.Network.aks_subnet_id

  acr_id = module.ACR.acr_id

  environment = var.environment

  depends_on = [module.NAT]
}

module "DNS" {
  source              = "../../modules/DNS"
  resource_group_name = module.ResourceGroup.resource_group_name
  location            = module.ResourceGroup.resource_group_location
  aks_identity_id     = module.AKS.aks_cluster_identity_id

  environment = var.environment
}

module "FrontDoor" {
  source                  = "../../modules/frontdoor"
  frontdoor_name          = var.acr_name
  frontdoor_endpoint_name = var.acr_name
  origin_group_name       = var.acr_name
  origin_name             = var.acr_name
  route_name              = var.acr_name

  resource_group_name = module.ResourceGroup.resource_group_name
  location            = module.ResourceGroup.resource_group_location

  environment = var.environment
}