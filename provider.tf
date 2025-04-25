terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.21.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=3.1.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-dev" #Change this to your resource group name that you want to store the state file in
    storage_account_name = "stterraformtfdev" #Change this to your storage account name that you want to store the state file in
    container_name       = "terraform-states" #Change this to your container name that you want to store the state file in
    key                  = "iac-grafana/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "00000000-0000-0000-0000-000000000000" #Change this to your subscription ID
}

provider "azuread" {
  tenant_id = "00000000-0000-0000-0000-000000000000" #Change this to your tenant ID
}
