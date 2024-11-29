terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.11.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "backend"
    storage_account_name = "007sl1234backend"
    container_name       = "backend"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
