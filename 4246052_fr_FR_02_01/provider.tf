terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.11.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.77.0"
    }
  }
}

provider "azurerm" {
  features {}
}
