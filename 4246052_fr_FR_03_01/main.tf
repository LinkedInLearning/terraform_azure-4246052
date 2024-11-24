resource "azurerm_resource_group" "web" {
  name     = var.rg
  location = var.region
}

resource "azurerm_storage_account" "web" {
  name                     = "007sl1234"
  resource_group_name      = azurerm_resource_group.web.name
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "test"
  }
}

resource "azurerm_storage_account_static_website" "web" {
  storage_account_id = azurerm_storage_account.web.id
  error_404_document = "error.html"
  index_document     = "index.html"
}

resource "azurerm_storage_blob" "web" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.web.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}


