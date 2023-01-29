output "region-vnet-address-space" {
  value = azurerm_virtual_network.region.address_space
}
output "region-vnet-snet-range" {
  value = azurerm_subnet.region_subnet.address_prefixes
}

output "region-subnet-id" {
  value = azurerm_subnet.region_subnet.id
}
