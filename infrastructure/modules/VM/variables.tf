variable "resource_group_name" {}
variable "location" {}

variable "agent_subnet_id" {}

variable "environment" {
  type = string
}

################################

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

################################

# Network Interface 
variable "agent_private_ip" {
  type    = string
  default = "10.224.0.70"
}