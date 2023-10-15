provider "azurerm" {
  features {}
}

module "my_storage_account" {
  source                   = "./azure_storage_module" # Path to the module directory
  resource_group_name      = "my-resource-group"
  location                 = "East US"
  storage_account_name     = "mystorageaccount"
}

output "my_storage_account_id" {
  description = "ID of the created Azure Storage Account."
  value       = module.my_storage_account.storage_account_id
}

output "my_storage_account_primary_key" {
  description = "Primary access key for the Azure Storage Account."
  value       = module.my_storage_account.storage_account_primary_key
}
