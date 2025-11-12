variable "resource_group_name" {}
variable "location" {}

variable "aks_identity_id" {}
variable "acr_subnet_id" {}
variable "virtual_network_id" {}

variable "environment" {
  type = string
}

################################

variable "acr_name" {
  type = string
}

variable "acr_sku" {
  type = string
}

################################

# ACR EndPoint
variable "EndPoint-ACR-name" {
  type    = string
  default = "ACR-EndPoint"
}

variable "EndPoint-acr-private-ip" {
  type    = string
  default = "10.224.0.110"
}
variable "EndPoint-acr-data-private-ip" {
  type    = string
  default = "10.224.0.111"
}