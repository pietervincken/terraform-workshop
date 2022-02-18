#!/bin/sh

if [ -z $subscription ]; then
    echo "Could not find subscription. Stopping!"
    exit 1
fi

if [ -z $rgstate ]; then
    echo "Could not find rgstate. Stopping!"
    exit 1
fi

if [ -z $location ]; then
    echo "Could not find location. Stopping!"
    exit 1
fi

if [ -z $sastate ]; then
    echo "Could not find sastate. Stopping!"
    exit 1
fi

az account set -s $subscription
az group show --name $rgstate || az group create -l $location -n $rgstate
az storage account show --name $sastate || (az storage account create -n $sastate -g $rgstate -l $location --sku Standard_LRS && az storage container create -n tfstate --account-name $sastate --public-access blob --auth-mode login)

rm prepare/config.azurerm.tfbackend

echo "resource_group_name  = \"$rgstate\""          >> prepare/config.azurerm.tfbackend
echo "storage_account_name = \"$sastate\""          >> prepare/config.azurerm.tfbackend
echo 'container_name       = "tfstate"'             >> prepare/config.azurerm.tfbackend
echo 'key                  = "terraform.tfstate"'   >> prepare/config.azurerm.tfbackend

echo "resource_group_name  = \"$rgstate\""          >> exercise/config.azurerm.tfbackend
echo "storage_account_name = \"$sastate\""          >> exercise/config.azurerm.tfbackend
echo 'container_name       = "tfstate"'             >> exercise/config.azurerm.tfbackend
echo 'key                  = "terraform.tfstate"'   >> exercise/config.azurerm.tfbackend