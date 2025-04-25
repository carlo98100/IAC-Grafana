variable "display_name" {
  type        = string
  nullable    = false
  description = "Name of the web app"
}

variable "redirect_urls" {
  type        = list(string)
  description = "List of redirect URLs"

}
