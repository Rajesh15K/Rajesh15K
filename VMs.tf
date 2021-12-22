resource "azurerm_windows_virtual_machine" "maivm4" {
 name                  = "${var.prefix}-vm4"
  location              = azurerm_resource_group.mainRG.location
  resource_group_name   = azurerm_resource_group.mainRG.name
  network_interface_ids = [azurerm_network_interface.mainNIC4.id]
  size                = "Standard_B1ls"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "mainNIC4" {
  name                = "${var.prefix}-nic4"
  location            = azurerm_resource_group.mainRG.location
  resource_group_name = azurerm_resource_group.mainRG.name

  ip_configuration {
    name                          = "testconfiguration4"
    subnet_id                     = azurerm_subnet.Subnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}
 