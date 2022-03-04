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
    yabo = "yannick.bontemps@ordina.be"
    duca = "duncan.casteleyn@ordina.be"
    kego = "kevin.govaerts@ordina.be"
    jeve = "jeroen.vereecken@ordina.be"
    jast = "jago.staes@ordina.be"
    nija = "niels.jacquet@ordina.be"
    kolu = "koen.luyten@ordina.be"
    olhe = "olivier.hermans@ordina.be"
    kabo = "katrien.boesmans@ordina.be"
    gesi = "gertjan.silkens@ordina.be"
    chde = "chris.debruyne@ordina.be"
    miva = "michiel.vanreybrouck@ordina.be"
    maca = "maarten.casteels@ordina.be"
    suqu = "sujith.quintelier@ordina.be"
    joli = "jorrit.linnert@ordina.nl"
    frbo = "frederick.bousson@ordina.be"
    nihe = "nick.heymans@ordina.be"
    sava = "sam.vancutsem@ordina.be"
  }
}

module "participants" {
  for_each    = local.participants
  source      = "./modules/participant"
  name        = each.key
  common_tags = local.common_tags
  email       = each.value
}
