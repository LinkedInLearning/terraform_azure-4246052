locals {
  environment = "development"
}

resource "azurerm_resource_group" "web" {
  name     = "web"
  location = "West Europe"
  tags = {
    Env = local.environment
  }
}

resource "azurerm_virtual_network" "web" {
  name                = "web-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.web.location
  resource_group_name = azurerm_resource_group.web.name
  tags = {
    Env = local.environment
  }
}

resource "azurerm_subnet" "web" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.web.name
  virtual_network_name = azurerm_virtual_network.web.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "web1" {
  name                = "web-nic1"
  location            = azurerm_resource_group.web.location
  resource_group_name = azurerm_resource_group.web.name
  tags = {
    Env = local.environment
  }

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface" "web2" {
  name                = "web-nic2"
  location            = azurerm_resource_group.web.location
  resource_group_name = azurerm_resource_group.web.name
  tags = {
    Env = local.environment
  }

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "web1" {
  name                = "web-machine1"
  resource_group_name = azurerm_resource_group.web.name
  location            = azurerm_resource_group.web.location
  tags = {
    Env = local.environment
  }
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.web1.id,
  ]

  admin_ssh_key {
    username   = var.username
    public_key = file(var.public_key_file)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "web2" {
  name                = "web-machine2"
  resource_group_name = azurerm_resource_group.web.name
  location            = azurerm_resource_group.web.location
  tags = {
    Env = local.environment
  }
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.web2.id,
  ]

  admin_ssh_key {
    username   = var.username
    public_key = file(var.public_key_file)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
