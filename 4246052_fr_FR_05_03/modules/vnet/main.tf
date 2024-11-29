resource "azurerm_virtual_network" "vnet" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "subnet" {
  resource_group_name  = var.resource_group_name
  name                 = var.subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_space]
}
