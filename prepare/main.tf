# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
locals {
  common_tags = {
    created-by = "pieter.vincken@ordina.be"
    project    = "terraform-workshop"
  }
  location = "West Europe"
  rg       = "rg-terraform-workshop"
  participants = {
    pivi = "pieter.vincken@ordina.be"
    maca = "maarten.casteels@ordina.be"
  }
}

module "participants" {
  for_each    = local.participants
  source      = "./modules/participant"
  name        = each.key
  common_tags = local.common_tags
  email       = each.value
}
