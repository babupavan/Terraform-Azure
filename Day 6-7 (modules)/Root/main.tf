provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

provider "azurerm" {
  features {}
}

module "vnet" {
  source              = "./modules/vnet"
  vnet_name           = var.vnet_name
  vnet_address_prefix = var.vnet_address_prefix
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "subnet" {
  source              = "./modules/subnet"
  vnet_name           = module.vnet.vnet_name
  subnet_name         = var.subnet_name
  subnet_address_prefix = var.subnet_address_prefix
  resource_group_name = var.resource_group_name
}

module "nsg" {
  source              = "./modules/nsg"
  nsg_name            = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location
}