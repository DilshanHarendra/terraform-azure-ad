# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}


# Create tenant
resource "azurerm_aadb2c_directory" "tenant" {
  country_code            = "SG"
  data_residency_location = "Asia Pacific"
  display_name            = var.display_name
  domain_name             = "dperera.onmicrosoft.com"
  resource_group_name     =  var.resource_group_name
  sku_name                = "PremiumP1"
  tags = {
    Environment = var.env
    Version     = "01122022"
  }
}
