resource "azurerm_resource_group" "backend" {
  name     = "backend"
  location = "West Europe"
}

resource "azurerm_storage_account" "backend" {
  name                     = "007sl1234backend"
  resource_group_name      = azurerm_resource_group.backend.name
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "GRS"

}
resource "azurerm_storage_container" "backend" {
  name                  = "backend"
  storage_account_id    = azurerm_storage_account.backend.id
  container_access_type = "private"
}


