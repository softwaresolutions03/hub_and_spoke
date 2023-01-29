# Networks 
# Region 1 VNET 1
resource "azurerm_virtual_network" "region" {
  name                = "${var.region}-vnet-01"
  location            = var.region
  resource_group_name = var.rg-name
  address_space       = [var.region-vnet-address-space]
  tags = {
    Environment = var.environment
  }
}
resource "azurerm_subnet" "region_subnet" {
  name                 = "${var.region}-vnet-01-snet-01"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.region.name
  address_prefixes     = [var.region-vnet-snet-range]
}
# # Region 2 VNET 1
# resource "azurerm_virtual_network" "region_2-vnet1" {
#   name                = "${var.region_2}-vnet-01"
#   location            = var.region_2
#   resource_group_name = var.rg-name
#   address_space       = [var.region_2-vnet1-address-space]
#   tags = {
#     Environment = var.environment_tag
#   }
# }
# resource "azurerm_subnet" "region_2-vnet1-snet1" {
#   name                 = "${var.region_2}-vnet-01-snet-01"
#   resource_group_name  = var.rg-name
#   virtual_network_name = azurerm_virtual_network.region_2-vnet1.name
#   address_prefixes     = [var.region_2-vnet1-snet1-range]
# }
# # NSGs
# #Lab NSG
# resource "azurerm_network_security_group" "region_1-nsg" {
#   name                = "${var.region_1}-nsg-01"
#   location            = var.region_1
#   resource_group_name = var.rg-name

#   security_rule {
#     name                       = "RDP-In"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "3389"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
#   tags = {
#     Environment = var.environment_tag
#   }
# }
# resource "azurerm_network_security_group" "region_2-nsg" {
#   name                = "${var.region_2}-nsg-01"
#   location            = var.region_2
#   resource_group_name = var.rg-name

#   security_rule {
#     name                       = "RDP-In"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "3389"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
#   tags = {
#     Environment = var.environment_tag
#   }
# }
# # NSG Association
# resource "azurerm_subnet_network_security_group_association" "region_1-vnet1-snet1" {
#   subnet_id                 = azurerm_subnet.region_1-vnet1-snet1.id
#   network_security_group_id = azurerm_network_security_group.region_1-nsg.id
# }
# resource "azurerm_subnet_network_security_group_association" "region_2-vnet1-snet1" {
#   subnet_id                 = azurerm_subnet.region_2-vnet1-snet1.id
#   network_security_group_id = azurerm_network_security_group.region_2-nsg.id
# }