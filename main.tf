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

#create resource group
resource "azurerm_resource_group" "rg" {
  name     = "sysco_demo_rg"
  location = "Southeast Asia"
  tags = {
    Environment = "Dev"
    Version     = "29112022"
  }
}

#create Active Directory tenant
resource "azurerm_aadb2c_directory" "commerce_apps_tenant" {
  country_code            = "SG"
  data_residency_location = "Asia Pacific"
  display_name            = "commerce-apps-tenant"
  domain_name             = "commerceapps.onmicrosoft.com"
  resource_group_name     = azurerm_resource_group.rg.name
  sku_name                = "PremiumP1"
  tags = {
    Environment = "Dev"
    Version     = "29112022"
  }
}

#Register Application
resource "azuread_application" "graph_worker" {
  display_name     = "GraphWorker_App"
  sign_in_audience = "AzureADMyOrg"
  web {
    redirect_uris = ["http://localhost/"]
  }
}
