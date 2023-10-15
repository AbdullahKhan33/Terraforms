provider "azurerm" {
  features {}
}

provider "random" {}  # Ensure you have this declared

resource "random_string" "unique" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

# Create multiple storage accounts using count
resource "azurerm_storage_account" "example" {
  count               = 3  # This creates 3 storage accounts
  name                = "mystorage${random_string.unique.result}${count.index}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  account_tier        = "Standard"
  account_replication_type = "LRS"
}

# Create a virtual network that depends on all storage accounts
resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]

  # Depends on ensures this resource is created after all storage accounts
  depends_on          = [azurerm_storage_account.example]
}
