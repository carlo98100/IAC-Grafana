output "client_id" {
  description = "value of the client_id"
  value       = azuread_application.grafana_app_reg.client_id
  sensitive   = true
}

output "client_secret_value" {
  value     = azuread_application_password.grafana_app_reg_secret.value
  sensitive = true
}
