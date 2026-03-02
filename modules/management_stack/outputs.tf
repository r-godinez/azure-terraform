output "log_analytics_workspace_id" {
    value = azurerm_log_analytics_workspace.law.id
}

output "key_vault_id" {
    value = azurerm_key_vault.kv.id
}
