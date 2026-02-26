# azure-terraform

## Focus on

- Managing identities (Azure AD basics)

- Managing governance (RGs, tags, policies)

- Managing storage

- Deploying and managing compute

- Configuring virtual networking

- Monitoring and backup

## Core Concepts

### Modules

- resource_group = governance layer

- networking = VNet + subnet + NSG

- linux_vm = compute

- storage_account = storage

Each module is isolated and reusable.

### Networking

Create:

- VNet

- Subnet

- NSG

- Associate NSG to subnet

This reinforces AZ-104 networking objectives.

### Remote Backend

- Storage Accounts

- State management

- Access control

#### Helps understand

- Blob storage

- RBAC

- Access keys

- Azure identity

## File Naming

| File         | Purpose                  |
| ------------ | ------------------------ |
| main.tf      | resources & module calls |
| variables.tf | input variables          |
| outputs.tf   | outputs                  |
| locals.tf    | computed values          |
| data.tf      | data sources (optional)  |

```bash
main.tf        # resources + module calls
variables.tf   # inputs
outputs.tf     # exposed values
locals.tf      # computed values (optional but recommended)
data.tf        # data sources (optional)
```


## Set-up

### Verify Dependencies

```bash
# Terrafrom
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

terraform -v

# Azure log in
az login

# Confirm subscription
az account show --output table

# Set subscription
az account set --subscription ""

az upgrade

# Initialize & Apply
terraform init
terraform plan
terraform apply

# Clean up
terraform destroy
```

```bash
# Create storage for terrform state
# Create resource group
az group create \
  --name rg-tfstate-westus3-prod \
  --location westus3

# Create storage account
az storage account create \
  --name sttfstatewestus3prod01 \
  --resource-group rg-tfstate-westus3-prod \
  --location westus3 \
  --sku Standard_LRS \
  --kind StorageV2 \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false

# RBAC permissions
# OBJECT_ID
az ad signed-in-user show --query id -o tsv
# SUB_ID
az account show --query id -o tsv
# Assign role
az role assignment create \
  --assignee <OBJECT_ID> \
  --role "Storage Blob Data Owner" \
  --scope /subscriptions/<SUB_ID>/resourceGroups/rg-tfstate-westus3-prod/providers/Microsoft.Storage/storageAccounts/sttfstatewestus3prod01

# Enable soft delete + versioning
az storage account blob-service-properties update \
  --account-name sttfstatewestus3prod01 \
  --resource-group rg-tfstate-westus3-prod \
  --enable-delete-retention true \
  --delete-retention-days 7 \
  --enable-versioning true

# Verify
az storage account blob-service-properties show \
  --account-name sttfstatewestus3prod01 \
  --resource-group rg-tfstate-westus3-prod \
  --output table

# Create container
az storage container create \
  --name tfstate \
  --account-name sttfstatewestus3prod01 \
  --auth-mode login

# Initialize
terraform init

# Verify
az storage blob list \
  --account-name sttfstatewestus3prod01 \
  --container-name tfstate \
  --auth-mode login \
  --output table
```
