# Networks 
# # NSGs
# #Lab NSG
resource "azurerm_network_security_group" "region-nsg" {
  name                = "${var.region}-nsg-01"
  location            = var.region
  resource_group_name = var.rg-name

  security_rule {
    name                       = "RDP-In"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = {
    Environment = var.environment
  }
}

# # NSG Association
resource "azurerm_subnet_network_security_group_association" "region-vnet-snet" {
  #subnet_id                 = module.networks.region-subnet-id.id
  subnet_id = var.subnet_id
  network_security_group_id = azurerm_network_security_group.region-nsg.id
}
# resource "azurerm_subnet_network_security_group_association" "region_2-vnet1-snet1" {
#   subnet_id                 = azurerm_subnet.region_2-vnet1-snet1.id
#   network_security_group_id = azurerm_network_security_group.region_2-nsg.id
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
