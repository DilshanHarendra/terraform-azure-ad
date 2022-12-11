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

locals {
  id1         = "8614d4b2-b701-ed19-990a-c4c01d836b23"
  id2         = "50dfecd9-4d6a-023e-641f-e6d124e40af1"
  scope_name  = "product"
}

data "azuread_client_config" "current" {}

resource "azuread_application" "api" {
  display_name     = var.display_name
  sign_in_audience = "AzureADandPersonalMicrosoftAccount"
  identifier_uris  = ["https://${var.tenant_domain}/${local.scope_name}-api"]
  owners = [data.azuread_client_config.current.object_id]
  api {
    requested_access_token_version = 2

    oauth2_permission_scope {
      id                         = local.id1
      admin_consent_description  = "Allow read access to ${local.scope_name} api"
      admin_consent_display_name = "Read access to api"
      enabled                    = true
      type                       = "Admin"
      value                      = "${local.scope_name}.read"
    }

    oauth2_permission_scope {
      id                         = local.id2
      admin_consent_description  = "Allow write access to ${local.scope_name} api"
      admin_consent_display_name = "Write access to api"
      enabled                    = true
      type                       = "Admin"
      value                      = "${local.scope_name}.write"
    }
  }


}

