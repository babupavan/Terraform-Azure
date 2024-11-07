variable "resource_group_name" {
  type    = string
  default = "demo-rg"  # Update with a valid RG name
}

variable "location" {
  type    = string
  default = "Central India"  # Update with your desired Azure region
}

variable "vnet_name" {
  type    = string
  default = "MyVirtualNetwork"  # A valid virtual network name
}

variable "vnet_address_prefix" {
  type    = string
  default = "10.0.0.0/16"  # A valid CIDR block for the VNet
}

variable "subnet_name" {
  type    = string
  default = "MySubnet"  # A valid subnet name
}

variable "subnet_address_prefix" {
  type    = string
  default = "10.0.1.0/24"  # A valid CIDR block for the Subnet
}

variable "nsg_name" {
  type    = string
  default = "MyNSG"  # A valid NSG name
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

variable "subnet_prefix" {
  description = "The address prefix for the subnet."
  type        = string
  default     = "10.0.1.0/24"  # A valid CIDR block for the Subnet
}
