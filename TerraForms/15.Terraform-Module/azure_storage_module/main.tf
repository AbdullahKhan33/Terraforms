provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

output "storage_account_id" {
  description = "ID of the created Azure Storage Account."
  value       = azurerm_storage_account.example.id
}

output "storage_account_primary_key" {
  description = "Primary access key for the Azure Storage Account."
  value       = azurerm_storage_account.example.primary_access_key
}
