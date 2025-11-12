# Environment Variable  =  "dev"
variable "environment" {
  type = string
}

#####################################

# Resource Group Infra
variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
  type = string
}

#####################################

# Virtual Network
variable "virtual_network_name" {
  type = string
}
variable "virtual_network_address" {
  type = string
}

#####################################

# infrastructure Subnet
variable "infra_subnet_name" {
  type = string
}
variable "infra_subnet_address" {
  type = string
}
# AKS Cluster Subnet
variable "aks_subnet_name" {
  type = string
}
variable "aks_subnet_address" {
  type = string
}

# Database Subnet
variable "db_subnet_name" {
  type = string
}
variable "db_subnet_address" {
  type = string
}

# VPN Subnet
variable "vpn_subnet_name" {
  type = string
}
variable "vpn_subnet_address" {
  type = string
}

# NAT Subnet
variable "nat_subnet_name" {
  type = string
}
variable "nat_subnet_address" {
  type = string
}

###########################################

# Azure container registry
variable "acr_name" {
  type = string
}

variable "acr_sku" {
  type = string
}

#####################################

# Flexible MySQL Server
variable "mysql_name" {
  type = string
}
variable "mysql_user" {
  type = string
}
variable "mysql_version" {
  type = string
}
variable "mysql_sku" {
  type = string
}

# Replica MySQL Server
variable "mysql_replica_name" {
  type = string
}

# DNS for MySQL server
variable "mysql_dns_zone_name" {
  type = string
}

#####################################

# Azure DevOps Agent
variable "agent_vm_name" {
  type = string
}

variable "agent_vm_size" {
  type = string
}

variable "agent_vm_admin_username" {
  type = string
}

variable "agent_vm_os_disk_type" {
  type = string
}

variable "agent_vm_os_disk_size_gb" {
  type = number
}

variable "agent_vm_image_sku" {
  type = string
}

variable "agent_private_ip" {
  type = string
}

########################################

variable "vpn_public_ip_name" {
  type    = string
  default = "vpn-gateway-pip"
}

variable "vpn_gateway_name" {
  type    = string
  default = "vpn-gateway"
}

variable "vpn_gateway_sku" {
  type    = string
  default = "VpnGw1"
}

variable "vpn_address_pool" {
  type    = list(string)
  default = ["172.16.0.0/24"] # static IP pool for VPN clients
}

########################################

# NAT gateway variables
variable "nat_public_ip_name" {
  type    = string
  default = "pip-nat-gateway"
}

variable "nat_gateway_name" {
  type    = string
  default = "nat-gateway"
}

#####################################

variable "aks_version" {
  type = string
}

variable "aks_name" {
  type = string
}

variable "aks_resources_rg" {
  type = string
}

variable "aks_sku" {
  type = string
}

# Agent Pool
variable "agent_pool_name" {
  type = string
}

variable "agent_pool_node_count" {
  type = number
}

variable "agent_pool_node_min_count" {
  type = number
}

variable "agent_pool_node_max_count" {
  type = number
}

variable "agent_pool_pods_node" {
  type = number
}

variable "agent_pool_os_sku" {
  type = string
}

variable "agent_pool_os_disk_type" {
  type = string
}

variable "agent_pool_os_disk_size" {
  type = number
}

variable "agent_pool_vm_size" {
  type = string
}


# User Pool
variable "user_pool_name" {
  type = string
}

variable "user_pool_vm_size" {
  type = string
}

variable "user_pool_node_count" {
  type = number
}

variable "user_pool_node_min_count" {
  type = number
}

variable "user_pool_node_max_count" {
  type = number
}

variable "user_pool_pods_node" {
  type = number
}

variable "user_pool_os_sku" {
  type = string
}

variable "user_pool_os_disk_type" {
  type = string
}

variable "user_pool_os_disk_size" {
  type = number
}

##########################################

variable "frontdoor_name" {
  type = string
}

variable "frontdoor_endpoint_name" {
  type = string
}

variable "origin_group_name" {
  type = string
}

variable "origin_name" {
  type = string
}

variable "route_name" {
  type = string
}