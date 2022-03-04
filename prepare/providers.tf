terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.97.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.18.0"
    }
  }
  backend "azurerm" {
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  # subscription_id = "" # Set through ENV subscription
}

# Configure the Azure Active Directory Provider
provider "azuread" {
  # tenant_id = "" # Set through ENV tenantid
}
