resource "azurerm_resource_group" "web" {
  name     = var.rg_name
  location = var.region
}

module "vnet1" {
  source               = "./modules/vnet"
  resource_group_name  = var.rg_name
  location             = var.region
  vnet_name            = "web_vnet"
  vnet_address_space   = "10.0.0.0/16"
  subnet_name          = "internal"
  subnet_address_space = "10.0.2.0/24"
  depends_on = [
    azurerm_resource_group.web
  ]
}
module "vnet2" {
  source               = "./modules/vnet"
  depends_on = [
    azurerm_resource_group.web
  ]
}

resource "azurerm_network_interface" "web" {
  name                = "web-nic1"
  location            = azurerm_resource_group.web.location
  resource_group_name = azurerm_resource_group.web.name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet1.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_resource_group.web
  ]
}
