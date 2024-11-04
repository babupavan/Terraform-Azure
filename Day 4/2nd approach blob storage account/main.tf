# Configure the Azure provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# Create a Storage Account
resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a Blob Container
resource "azurerm_storage_container" "example" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "blob"  # Public access
}

# Upload a file using Azure CLI via local-exec provisioner
resource "null_resource" "upload_file" {
  provisioner "local-exec" {
    command = "az storage blob upload --account-name ${azurerm_storage_account.example.name} --container-name ${azurerm_storage_container.example.name} --name ${var.blob_name} --file ${var.file_path} --account-key ${azurerm_storage_account.example.primary_access_key}"
  }
  depends_on = [
    azurerm_storage_account.example,
    azurerm_storage_container.example
  ]
}
