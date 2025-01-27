terraform {

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.11.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.76.0"
    }
    oci = {
      source = "oracle/oci"
      version = ">= 6.14.0 , < 6.18.0"
    }
    
  }

  required_version = "> 1.5.0"

}

provider "azurerm" {
  # Configuration options
}
