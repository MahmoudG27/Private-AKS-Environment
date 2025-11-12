resource "azurerm_linux_virtual_machine" "agent_vm" {
  name                            = var.agent_vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.agent_vm_size
  admin_username                  = var.agent_vm_admin_username
  admin_password                  = random_password.agent_password.result
  computer_name                   = "agent"
  disable_password_authentication = false
  zone                            = 1
  network_interface_ids           = [azurerm_network_interface.agent_nic.id]
  #  custom_data                     = base64encode(file("runner.sh"))

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.agent_vm_os_disk_type
    disk_size_gb         = var.agent_vm_os_disk_size_gb
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = var.agent_vm_image_sku
    version   = "latest"
  }
}