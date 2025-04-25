variable "name" {
  type        = string
  nullable    = false
  description = "Name of the web app"
}

variable "location" {
  type        = string
  description = "Location of the web app"
  nullable    = false
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group"
  nullable    = false
}

variable "app_settings" {
  type        = map(string)
  description = "App settings for the web app"
  nullable    = true
  default     = {}
}
