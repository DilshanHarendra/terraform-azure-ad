# Configure the Azure provider

/*
* more info : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#features
*/
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

#Register Applications
module "api_application" {
  source       = "./api_application"
  display_name = "fashion-store-api"
  tenant_id    = module.tenant.tenant_id
  tenant_domain = module.tenant.tenant_domain_name
}


module "public_client_application" {
  source       = "./public_client_application"
  display_name = "fashion-store-public"
  tenant_id    = module.tenant.tenant_id
  api_application = module.api_application.api_application
}

module "internal_client_application" {
  source       = "./internal_client_application"
  display_name = "fashion-store-internal"
  tenant_id    = module.tenant.tenant_id
  api_application = module.api_application.api_application
}
