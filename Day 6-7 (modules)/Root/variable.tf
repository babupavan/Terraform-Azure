variable "resource_group_name" {
  type = string
  default = "resource group for resources"
}

variable "location" {
  type = string
  default = "location for the resources"
}

variable "vnet_name" {
  type = string
  default = "virtual network name "
}

variable "vnet_address_prefix" {
  type = string
  default = "address prefix for virtual network"
}

variable "subnet_name" {
  type = string
  default = "name of subnet"
}

variable "subnet_address_prefix" {
  type = string
  default = "address prefix for subnet "
}

variable "nsg_name" {
  type = string
  default = "name of the nsg"
}

# Provider authentication variables
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "client_id" {
  description = "Azure client ID"
  type        = string
}

variable "client_secret" {
  description = "Azure client secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}
