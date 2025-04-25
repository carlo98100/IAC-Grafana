resource "azurerm_service_plan" "asp_service_plan" {
  name                = "asp-${var.name}"
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = "F1"
  os_type             = "Linux"
}

resource "azurerm_linux_web_app" "app_grafana" {
  name                = "app-${var.name}"
  location            = var.location
  resource_group_name = var.rg_name
  service_plan_id     = azurerm_service_plan.asp_service_plan.id
  https_only          = true

  site_config {
    always_on = false

    application_stack {
      docker_image_name = "grafana/grafana:latest"
    }
  }
  app_settings = var.app_settings
}
