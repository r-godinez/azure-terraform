output "vnet_id" {
  value = azurerm_virtual_network.hub.id
}

output "vnet_name" {
  value = azurerm_virtual_network.hub.name
}

output "subnet_ids" {
  value = {
    bastion  = azurerm_subnet.bastion.id
    firewall = azurerm_subnet.firewall.id
    mgmt     = azurerm_subnet.mgmt.id
  }
}