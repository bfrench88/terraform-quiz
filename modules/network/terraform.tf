// create network
resource "azurerm_virtual_network" "vnet" {
  name                = "VirtualNetwork"
  address_space       = ["${var.network_address_space}"]
  location            = var.location
  resource_group_name = var.resource_group_name
}
