#!/bin/bash

export ARM_SUBSCRIPTION_ID=$subscription
export ARM_TENANT_ID=$tenantid

cd prepare
terraform init -backend-config=config.azurerm.tfbackend
terraform apply
cd ..