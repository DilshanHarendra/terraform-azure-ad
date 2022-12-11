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

data "azuread_client_config" "current" {}


locals {
  permission_scopes = tolist(element(var.api_application.api,0).oauth2_permission_scope)
}


resource "azuread_application" "public_app" {
  display_name     = var.display_name
  sign_in_audience = "AzureADandPersonalMicrosoftAccount"
  owners = [data.azuread_client_config.current.object_id]
  fallback_public_client_enabled = true
  api {
    requested_access_token_version = 2
  }

  web {
    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }

  required_resource_access {
    resource_app_id = var.api_application.application_id

    resource_access {
      id   = local.permission_scopes[index(local.permission_scopes.*.value,"product.read")].id
      type = "Scope"
    }
  }

  single_page_application {
    redirect_uris = ["http://localhost:3000/","https://jwt.ms/"]
  }

}
