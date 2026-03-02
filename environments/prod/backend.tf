terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-westus3-prod"
    storage_account_name = "sttfstatewestus3prod01"
    container_name       = "tfstate"
    key                  = "enterprise-prod.tfstate"
  }
}