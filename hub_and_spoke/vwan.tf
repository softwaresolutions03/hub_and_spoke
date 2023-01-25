# Creating the Virtual WAN:
# vWAN
resource "azurerm_virtual_wan" "vwan_1" {
  name                = "${var.lab-name}-vWAN-01"
  resource_group_name = var.rg-name
  location            = var.region_1
  tags = {
    Environment = var.environment_tag
  }
}

# Creating the Virtual WAN Hubs:
# vWAN Hub 1
resource "azurerm_virtual_hub" "region_1-vhub_1" {
  name                = "${var.region_1}-vWAN-hub-01"
  resource_group_name = var.rg-name
  location            = var.region_1
  virtual_wan_id      = azurerm_virtual_wan.vwan_1.id
  address_prefix      = var.vwan-region_1-hub_1-prefix_1

  tags = {
    Environment = var.environment_tag
  }
}
# vWAN Hub 2
resource "azurerm_virtual_hub" "region_2-vhub_1" {
  name                = "${var.region_2}-vWAN-hub-02"
  resource_group_name = var.rg-name
  location            = var.region_2
  virtual_wan_id      = azurerm_virtual_wan.vwan_1.id
  address_prefix      = var.vwan-region_2-hub_1-prefix_1

  tags = {
    Environment = var.environment_tag
  }
}

# Creating the Hub to Spoke Connections:

# vWAN Hub Connection 1
resource "azurerm_virtual_hub_connection" "region_1-connection1" {
  name                      = "${var.region_1}-conn-vnet1-to-vwan-hub"
  virtual_hub_id            = azurerm_virtual_hub.region_1-vhub_1.id
  remote_virtual_network_id = azurerm_virtual_network.region_1-vnet1.id
}
# vWAN Hub Connection 2
resource "azurerm_virtual_hub_connection" "region_2-connection1" {
  name                      = "${var.region_2}-conn-vnet1-to-vwan-hub"
  virtual_hub_id            = azurerm_virtual_hub.region_2-vhub_1.id
  remote_virtual_network_id = azurerm_virtual_network.region_2-vnet1.id
}