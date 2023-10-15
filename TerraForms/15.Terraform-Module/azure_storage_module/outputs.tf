output "storage_account_id" {
  description = "ID of the created Azure Storage Account."
  value       = azurerm_storage_account.example.id
}

output "storage_account_primary_key" {
  description = "Primary access key for the Azure Storage Account."
  value       = azurerm_storage_account.example.primary_access_key
}
