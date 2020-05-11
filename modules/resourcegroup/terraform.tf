// Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "resg" {
  name     = "${var.resource_group_name}_${var.id}"
  location = var.location
}
