# main.tf file (for root module)

# Resource Group Creation
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network Creation
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_prefix]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  # Ensure VNet creation after RG creation
  depends_on = [azurerm_resource_group.rg]
}
  
