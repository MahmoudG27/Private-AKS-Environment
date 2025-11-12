# inheritance from root module
variable "resource_group_name" {}
variable "location" {}

variable "environment" {
  type = string
}

################################

# Virtual Network

variable "virtual_network_name" {
  type = string
}
variable "virtual_network_address" {
  type = string
}
########################################

# infrastructure Subnet like VM, ACR
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

# MYSQL Subnet
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

# NAT gateway Subnet
variable "nat_subnet_name" {
  type = string
}
variable "nat_subnet_address" {
  type = string
}