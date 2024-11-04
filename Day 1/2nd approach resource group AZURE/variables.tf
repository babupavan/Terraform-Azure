variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "client_id" {
  description = "Azure Client ID"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Azure Client Secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "example-resource-group"
}

variable "location" {
  description = "Location of the Azure Resource Group"
  type        = string
  default     = "East US"
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}
