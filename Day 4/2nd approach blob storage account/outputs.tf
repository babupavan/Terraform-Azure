output "storage_account_name" {
  value = azurerm_storage_account.example.name
}

output "container_url" {
  value = azurerm_storage_container.example.id
}

output "file_url" {
  value = "https://${azurerm_storage_account.example.name}.blob.core.windows.net/${azurerm_storage_container.example.name}/azure.txt"
}
