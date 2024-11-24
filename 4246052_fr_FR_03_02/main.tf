resource "azurerm_resource_group" "web" {
  name     = var.rg
  location = var.region
}

