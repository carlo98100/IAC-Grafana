locals {
  project_name = "" #Set your project name here
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg_grafana" {
  name     = "rg-${local.project_name}-${var.environment}"
  location = "swedencentral"
}

module "grafana_webapp" {
  source   = "./modules/WebApp"
  name     = "${local.project_name}-${var.environment}"
  location = azurerm_resource_group.rg_grafana.location
  rg_name  = azurerm_resource_group.rg_grafana.name
  app_settings = {
    GF_SECURITY_ADMIN_USER             = "admin"
    GF_SECURITY_ADMIN_PASSWORD         = "password" #Change password for the admin user 
    GF_SERVER_ROOT_URL                 = "https://app-${local.project_name}-${var.environment}.azurewebsites.net",
    GF_AUTH_AZUREAD_NAME               = "Azure AD",
    GF_AUTH_AZUREAD_ENABLED            = "true",
    GF_AUTH_AZUREAD_CLIENT_ID          = module.grafana_app_reg.client_id,
    GF_AUTH_AZUREAD_CLIENT_SECRET      = module.grafana_app_reg.client_secret_value,
    GF_AUTH_AZUREAD_SCOPES             = "openid email profile",
    GF_AUTH_AZUREAD_AUTH_URL           = "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/oauth2/v2.0/authorize",
    GF_AUTH_AZUREAD_TOKEN_URL          = "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/oauth2/v2.0/token",
    GF_AUTH_AZUREAD_SKIP_ORG_ROLE_SYNC = "false"
  }
}

module "grafana_app_reg" {
  source       = "./modules/AppRegistration"
  display_name = "grafana"
  redirect_urls = [
    "https://app-${local.project_name}-${var.environment}.azurewebsites.net/",
    "https://app-${local.project_name}-${var.environment}.azurewebsites.net/login/azuread",
    "https://app-${local.project_name}-${var.environment}.azurewebsites.net/login/AZUREAD"
  ]
}


