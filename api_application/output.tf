output "app_id" {
  value = azuread_application.api.application_id
}

output "api_application" {
  value = azuread_application.api
}
