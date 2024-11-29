
module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "5.0.1"
  resource_group_name  = var.rg_name
  vnet_location        = var.region
  vnet_name            = "web_vnet"
}


resource "azurerm_network_interface" "web" {
  name                = "web-nic"
  resource_group_name = var.rg_name
  location            = var.region
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.vnet_subnets[0]
    private_ip_address_allocation = "Dynamic"
  }
}


