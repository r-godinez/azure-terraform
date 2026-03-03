# Resource Group (dynamically create RG)
resource "azurerm_resource_group" "hub_rg" {
  name     = "rg-hub-${var.location}-${var.environment}"
  location = var.location
  tags     = var.tags
}

# VNet
resource "azurerm_virtual_network" "hub" {
  name                = local.vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  address_space = [var.hub_cidr]

  tags = var.tags
}

# Bastion Subnet
resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.bastion_subnet]
}

# Firewall Subnet
resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.firewall_subnet]
}

# Management Subnet
resource "azurerm_subnet" "mgmt" {
  name                 = "snet-mgmt"
  resource_group_name = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.mgmt_subnet]
}