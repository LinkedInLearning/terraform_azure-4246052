resource "azurerm_resource_group" "web" {
  location = var.region
  name     = "web"
}

resource "azurerm_virtual_network" "web" {
  name                = "web"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.web.location
  resource_group_name = azurerm_resource_group.web.name
}

resource "azurerm_subnet" "web" {
  name                 = "web"
  resource_group_name  = azurerm_resource_group.web.name
  virtual_network_name = azurerm_virtual_network.web.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "web" {
  name                = "web"
  location            = azurerm_resource_group.web.location
  resource_group_name = azurerm_resource_group.web.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "web" {
  name                = "web"
  location            = azurerm_resource_group.web.location
  resource_group_name = azurerm_resource_group.web.name
  
  security_rule {
    name                       = "HTTP"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "web" {
  name                = "web"
  location            = azurerm_resource_group.web.location
  resource_group_name = azurerm_resource_group.web.name

  ip_configuration {
    name                          = "web"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web.id
  }
}

resource "azurerm_network_interface_security_group_association" "web" {
  network_interface_id      = azurerm_network_interface.web.id
  network_security_group_id = azurerm_network_security_group.web.id
}

resource "tls_private_key" "web" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "web" {
  name                  = "web"
  location              = azurerm_resource_group.web.location
  resource_group_name   = azurerm_resource_group.web.name
  network_interface_ids = [azurerm_network_interface.web.id]
  size                  = "Standard_DS1_v2"
 
  custom_data 		= filebase64("install-apache.sh")

  os_disk {
    name                 = "web"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "web"
  admin_username                  = "sadmin"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "sadmin"
    public_key = tls_private_key.web.public_key_openssh
  }
}




