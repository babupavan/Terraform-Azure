provider "azurerm" {
  features {}

  # Use environment variables or uncomment the lines below for direct configuration
  client_id       = "8172f1c0-5889-4363-8d5a-fb767761c87c"
  client_secret   = "************************************"
  tenant_id       = "2cea1ffe-f344-4620-8046-16e79eba4254"
  subscription_id = "323e5f0f-0395-4c7a-8d7a-0bcdcc22be25"
}

# Create Resource Group
resource "azurerm_resource_group" "example" {
  name     = "azuretrigent-blore-rg"
  location = "South India"
}

# Create Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

# Create Subnet
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create Public IP Address for the VM
resource "azurerm_public_ip" "example" {
  name                = "example-pip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
}

# Create Network Security Group (NSG) with HTTP and HTTPS rules
resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "allow-http"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create Network Interface and associate NSG
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }

  # Associate NSG
}

resource "azurerm_linux_virtual_machine" "example" {
  name                  = "example-vm"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  size                  = "Standard_B1s"
  admin_username        = "azureuser"
  admin_password        = "P@ssw0rd1234"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.example.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Specify the image reference
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  custom_data = base64encode(<<-EOT
    #!/bin/bash
    sudo apt update
    sudo apt install -y nginx
    echo '<html><body><h1>Login Page</h1><form method="POST"><label for="username">Username:</label><input type="text" id="username" name="username"><br><label for="password">Password:</label><input type="password" id="password" name="password"><br><input type="submit" value="Login"></form></body></html>' > /var/www/html/index.html
    sudo systemctl enable nginx
    sudo systemctl start nginx
  EOT
  )
}


# Output the public IP address and NSG
output "public_ip" {
  value = azurerm_public_ip.example.ip_address
}

output "nsg_id" {
  value = azurerm_network_security_group.example.id
}

output "nsg_name" {
  value = azurerm_network_security_group.example.name
}
