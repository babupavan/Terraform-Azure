variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "client_id" {
  description = "The client ID for Azure authentication"
  type        = string
}

variable "client_secret" {
  description = "The client secret for Azure authentication"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The Azure tenant ID"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "The Azure region for resources"
  type        = string
  default     = "West Europe"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "storageblob456"
}

variable "container_name" {
  description = "The name of the blob container"
  type        = string
  default     = "example-container"
}

variable "blob_name" {
  description = "The name of the blob file to upload"
  type        = string
}

variable "file_path" {
  description = "The local file path of the file to upload"
  type        = string
}
