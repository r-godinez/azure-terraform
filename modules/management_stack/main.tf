data "azurerm_client_config" "current" {}

# Resource Group
resource "azurerm_resource_group" "mgmt" {
    name        = local.rg_name
    location    = var.location
    tags        = var.tags
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
    name                    = local.law_name
    location                = var.location
    resource_group_name     = azurerm_resource_group.mgmt.name
    sku                     = "PerGB2018"
    retention_in_days       = 30

    tags                    = var.tags
}

# Key Vault (RBAC Mode)
resource "azurerm_key_vault" "kv" {
    name                            = local.kv_name
    location                        = var.location
    resource_group_name             = azurerm_resource_group.mgmt.name
    tenant_id                       = data.azurerm_client_config.current.tenant_id
    sku_name                        = "standard"

    purge_protection_enabled        = true
    rbac_authorization_enabled      = true
    soft_delete_retention_days      = 7

    public_network_access_enabled   = false
    tags                            = var.tags
}

# Resource Lock (CANNOT DELTE)
resource "azurerm_management_lock" "rg_lock" {
    name              = "mgmt-rg-lock"
    scope              = azurerm_resource_group.mgmt.id
    lock_level         = "CanNotDelete"
    notes              = "This lock prevents accidental deletion of the resource group."

    depends_on = [
        azurerm_key_vault.kv
    ]
}
# Comment out section to destroy the resource group and all resources within it
