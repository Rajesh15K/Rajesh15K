provider "azurerm" {
  features {}
}

# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  required_version = ">= 0.14.9"
}

/*resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "westus2"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
    name                = "myTFVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "westus2"
    resource_group_name = azurerm_resource_group.rg.name
}*/

variable "prefix" {
  default = "tfvmex"
}

resource "azurerm_resource_group" "mainRG" {
  name     = "${var.prefix}-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "mainVnet" {
  name                = "${var.prefix}-network"
  address_space       = ["197.10.10.0/24"]
  location            = azurerm_resource_group.mainRG.location
  resource_group_name = azurerm_resource_group.mainRG.name
}

resource "azurerm_subnet" "Subnet1" {
  name                 = "Subnet1"
  resource_group_name  = azurerm_resource_group.mainRG.name
  virtual_network_name = azurerm_virtual_network.mainVnet.name
  address_prefixes     = ["197.10.10.0/26"]
}

resource "azurerm_subnet" "Subnet2" {
  name                 = "Subnet2"
  resource_group_name  = azurerm_resource_group.mainRG.name
  virtual_network_name = azurerm_virtual_network.mainVnet.name
  address_prefixes     = ["197.10.10.64/26"]
}

resource "azurerm_subnet" "Subnet3" {
  name                 = "Subnet3"
  resource_group_name  = azurerm_resource_group.mainRG.name
  virtual_network_name = azurerm_virtual_network.mainVnet.name
  address_prefixes     = ["197.10.10.128/26"]
}

resource "azurerm_subnet" "Subnet4" {
  name                 = "Subnet4"
  resource_group_name  = azurerm_resource_group.mainRG.name
  virtual_network_name = azurerm_virtual_network.mainVnet.name
  address_prefixes     = ["197.10.10.192/26"]
}


resource "azurerm_network_interface" "mainNIC" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.mainRG.location
  resource_group_name = azurerm_resource_group.mainRG.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.Subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "mainNIC2" {
  name                = "${var.prefix}-nic2"
  location            = azurerm_resource_group.mainRG.location
  resource_group_name = azurerm_resource_group.mainRG.name

  ip_configuration {
    name                          = "testconfiguration2"
    subnet_id                     = azurerm_subnet.Subnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "mainVM1" {
  name                  = "${var.prefix}-vm1"
  location              = azurerm_resource_group.mainRG.location
  resource_group_name   = azurerm_resource_group.mainRG.name
  network_interface_ids = [azurerm_network_interface.mainNIC.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname1"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "staging"
  }
}

resource "azurerm_virtual_machine" "mainVM2" {
  name                  = "${var.prefix}-vm2"
  location              = azurerm_resource_group.mainRG.location
  resource_group_name   = azurerm_resource_group.mainRG.name
  network_interface_ids = [azurerm_network_interface.mainNIC2.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname2"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "staging"
  }
}

resource "azuread_user" "User1" {
  user_principal_name = "User1@advikrajgangwargmail.onmicrosoft.com"
  display_name        = "User1"
  mail_nickname       = "User1"
  password            = "P@sswd99!"
}

resource "azuread_user" "User2" {
  user_principal_name = "User2@advikrajgangwargmail.onmicrosoft.com"
  display_name        = "User2"
  mail_nickname       = "User2"
  password            = "P@sswd99!"
}

resource "azuread_user" "User3" {
  user_principal_name = "User3@advikrajgangwargmail.onmicrosoft.com"
  display_name        = "User3"
  mail_nickname       = "User3"
  password            = "P@sswd99!"
}

resource "azuread_user" "User4" {
  user_principal_name = "User4@advikrajgangwargmail.onmicrosoft.com"
  display_name        = "User4"
  mail_nickname       = "User4"
  password            = "P@sswd99!"
}

