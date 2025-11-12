variable "resource_group_name" {}
variable "location" {}

variable "environment" {
  type = string
}

################################################

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