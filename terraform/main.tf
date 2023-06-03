data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "baseRG" {
  name     = var.projectName
  location = "East US"
}
