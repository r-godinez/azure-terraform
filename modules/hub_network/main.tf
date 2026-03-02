# VNet
resource "azurerm_virtual_network" "hub" {
  name                = local.vnet_name
  location            = var.location
  resource_group_name = "rg-mgmt-${var.location}-${var.environment}"

  address_space = [var.hub_cidr]

  tags = var.tags
}

# Bastion Subnet
resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_virtual_network.hub.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.bastion_subnet]
}

# Firewall Subnet
resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_virtual_network.hub.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.firewall_subnet]
}

# Management Subnet
resource "azurerm_subnet" "mgmt" {
  name                 = "snet-mgmt"
  resource_group_name  = azurerm_virtual_network.hub.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.mgmt_subnet]
}