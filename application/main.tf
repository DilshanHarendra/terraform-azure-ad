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
  tenant_id = var.tenant_id
}

provider "azuread" {
  tenant_id = var.tenant_id
}

resource "azuread_application" "vendor_app" {
  display_name     = var.display_name
  sign_in_audience = "AzureADMultipleOrgs"

  web {
    homepage_url  = "http://localhost:3000"
    logout_url    = "http://localhost:3000/logout"
    redirect_uris = ["https://jwt.ms/","http://localhost:3000/"]

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }

  single_page_application {
    redirect_uris = ["http://localhost:3000/","http://localhost:8080/"]
  }

}
