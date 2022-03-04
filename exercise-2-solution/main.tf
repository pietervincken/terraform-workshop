terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.97.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-tfwspivi-playground-001"
    storage_account_name = "sapiviplayground001"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

locals {
  resource_group_name = "rg-tfwspivi-playground-001"
  location            = "northeurope"
  name                = "tfwspivi"
}

resource "azurerm_key_vault" "mykeyvault" {
  name                = "kv${local.name}"
  resource_group_name = local.resource_group_name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  location            = local.location
}

data "azurerm_client_config" "current" {
}

resource "azurerm_key_vault_access_policy" "myaccess" {
  key_vault_id = azurerm_key_vault.mykeyvault.id
  tenant_id    = azurerm_key_vault.mykeyvault.tenant_id
  object_id    = data.azurerm_client_config.current.object_id
  secret_permissions = [
    "Delete", "Get", "List", "Set", "Purge"
  ]
}


resource "azurerm_container_group" "aci-test" {
  name                = "aci-${local.name}-playground-001"
  location            = local.location
  resource_group_name = local.resource_group_name
  ip_address_type     = "public"
  dns_name_label      = local.name
  os_type             = "Linux"

  container {
    name   = "hello-world"
    image  = "pietervincken/snake-server:0.0.1"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 8080
      protocol = "TCP"
    }
  }

  tags = {
    environment = "testing"
  }
}
