# Configure the Azure provider
provider "azurerm" {
  features {}

  subscription_id = "************************************"
  client_id       = "************************************"
  client_secret   = var.client_secret  # Reference variable for sensitive data
  tenant_id       = "************************************"
}

# Variable for sensitive client secret
variable "client_secret" {
  description = "The client secret for Azure authentication."
  type        = string
  sensitive   = true
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

# Create a Storage Account with a specific name
resource "azurerm_storage_account" "example" {
  name                     = "storageblob456"   # Set to desired name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a Blob Container
resource "azurerm_storage_container" "example" {
  name                  = "example-container"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "blob"  # Change to "blob" if you want public access
}

# Upload a file to the Blob Container using Azure CLI via local-exec provisioner
resource "null_resource" "upload_file" {
  provisioner "local-exec" {
    command = "az storage blob upload --account-name ${azurerm_storage_account.example.name} --container-name ${azurerm_storage_container.example.name} --name azure.txt --file C:\\Users\\latha_paladugu\\Documents\\azure.txt --account-key ${azurerm_storage_account.example.primary_access_key}"
  }

  # Ensure storage account and container are created first
  depends_on = [
    azurerm_storage_account.example,
    azurerm_storage_container.example
  ]
}

# Output the Storage Account Name and Blob URL
output "storage_account_name" {
  value = azurerm_storage_account.example.name
}

output "container_url" {
  value = azurerm_storage_container.example.id
}

output "file_url" {
  value = "https://${azurerm_storage_account.example.name}.blob.core.windows.net/${azurerm_storage_container.example.name}/azure.txt"
}
