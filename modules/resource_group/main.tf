resource "azurerm_resource_group" "AZ-104-LAB" {
  name     = var.name
  location = var.location
  tags     = var.tags
}