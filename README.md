# Terraform Workshop

# Teacher setup

Make sure to create an .env file with the following properties filled out: 

```bash
export location="xxx"
export rgstate="xxx"
export sastate="xxx"
export subscription="xxx"
export tenantid="xxx"
```

Next, edit the `prepare/main.tf` to include a list of participants in the `participants` local variable. 
Add an entry for every participant. 

## Setup 
 
1. `source .env`: Make sure the variables above are available
1. `sh 0-prepare.sh`: Sets up the "root" state resource group and storage account (stores the state for the teacher setup)
1. `sh 1-terraform-apply.sh`: Creates the required components for each participant

## Tear down

1. `sh 99-terraform-destroy.sh`: Destroys the components that were created in `1-terraform-apply.sh`
1. `sh 100-destroy.sh`: Destroy Terraform state storage account