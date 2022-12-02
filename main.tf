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
module "resource_group" {
  source = "./resource_group"
  name   = "sysco_demo_rg"
  env    = "Dev"

}


#create Active Directory tenant
module "tenant" {
  source              = "./tenant"
  display_name        = "dperera-apps-tenant"
  env                 = "Dev"
  resource_group_name = module.resource_group.rg_name_output
}

#Register Application
module "application" {
  source       = "./application"
  display_name = "vendor-app3"
  tenant_id    = module.tenant.tenant_id
}

