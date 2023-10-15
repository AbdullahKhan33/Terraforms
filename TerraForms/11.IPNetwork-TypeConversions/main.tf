provider "azurerm" {
  features {}
}

# Define the base CIDR and calculate a subnet CIDR
locals {
  base_cidr   = "10.0.0.0/16"
  subnet_cidr = cidrsubnet(local.base_cidr, 8, 1) # Result: "10.0.1.0/24"
}

resource "azurerm_virtual_network" "example_vnet" {
  name                = "example-vnet"
  location            = "East US"
  resource_group_name = "example-resource-group"
  address_space       = [local.base_cidr]
}

resource "azurerm_subnet" "example_subnet" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_virtual_network.example_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.example_vnet.name
  address_prefixes     = [local.subnet_cidr]
}

# Convert the name of the subnet into a single-element list
output "subnet_name_list" {
  description = "The name of the subnet as a single-element list"
  value       = tolist(azurerm_subnet.example_subnet.name)
}

# Convert the enforce_private_link_endpoint_network_policies property of the subnet into a string
output "is_default_security_rules_string" {
  description = "Whether the subnet has default security rules as a string"
  value       = tostring(azurerm_subnet.example_subnet.enforce_private_link_endpoint_network_policies)
}
