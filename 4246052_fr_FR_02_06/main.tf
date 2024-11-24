data "azurerm_resource_group" "web" {
  name = "web_rg"
}

data "azurerm_resources" "web_res" {
  resource_group_name      = data.azurerm_resource_group.web.name

  required_tags = {
    environment = "test"
  }
}

resource "azurerm_storage_account" "web" {
  name                     = "4321sl007"
  resource_group_name      = data.azurerm_resource_group.web.name
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "test"
  }
}
