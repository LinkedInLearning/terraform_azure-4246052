resource "azurerm_resource_group" "web" {
  name     = var.rg
  location = var.region
}

resource "azurerm_virtual_network" "web" {
  name                = "web-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.web.location
  resource_group_name = azurerm_resource_group.web.name
}

resource "azurerm_subnet" "web" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.web.name
  virtual_network_name = azurerm_virtual_network.web.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "web" {
  name                = "web-nic"
  location            = azurerm_resource_group.web.location
  resource_group_name = azurerm_resource_group.web.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "web" {
  name                = "web-server"
  resource_group_name = azurerm_resource_group.web.name
  location            = azurerm_resource_group.web.location
  
  tags = {
    Type = var.size
    Env  = var.environment
    Ws   = terraform.workspace
  }

  size = var.size
  
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.web.id,
  ]
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("admin_id_rsa.pub")
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
