terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.97.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

locals {
  tenant_id           = "cbed0302-0bb5-413f-bba6-4b50f09b5470"
  resource_group_name = "rg-tfwspivi-playground-001"
  location            = "northeurope"
  name                = "tfwspivi"
}

data "azurerm_client_config" "current" {
}

resource "azurerm_key_vault" "mykeyvault" {
  name                = "kv${local.name}"
  resource_group_name = local.resource_group_name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  location            = local.location
}
