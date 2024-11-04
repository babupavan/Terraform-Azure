# Specify the required provider
provider "azurerm" {
  features {}

  subscription_id = "************************************"
  client_id       = "************************************"
  client_secret   = "************************************"  # Consider using a variable or environment variable
  tenant_id       = "************************************"
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "my-resource"
  location = "South India"  # Correct capitalization
}
