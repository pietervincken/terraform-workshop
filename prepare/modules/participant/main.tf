locals {
  extra_tags = {

  }
  tenant_domain = data.azuread_domains.aad_domains.domains.0.domain_name
  upn           = "${replace(var.email, "@", "_")}#EXT#@${local.tenant_domain}"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-tfws${var.name}-playground-001"
  location = var.location
  tags     = merge(var.common_tags, local.extra_tags)
}

data "azuread_user" "user" {
  user_principal_name = local.upn
}

data "azuread_domains" "aad_domains" {

}
resource "azurerm_role_assignment" "role" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_user.user.object_id
}

resource "azurerm_storage_account" "tfstorage" {
  name                     = "sa${var.name}playground001"
  location                 = var.location
  resource_group_name      = azurerm_resource_group.rg.name
  tags                     = merge(var.common_tags, local.extra_tags)
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfcontainer" {
  name                 = "tfstate"
  storage_account_name = azurerm_storage_account.tfstorage.name
}
