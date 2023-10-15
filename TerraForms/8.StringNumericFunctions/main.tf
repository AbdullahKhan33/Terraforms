provider "azurerm" {
  features {}
}

# Input variable for a potentially uppercase resource group name
variable "resource_group_name_input" {
  description = "The name of the Azure Resource Group"
  type        = string
  default     = "WALMART-RESOURCE-GROUP"
}

# Use the `lower` function to ensure the resource group name is in lowercase
locals {
  resource_group_name_processed = lower(var.resource_group_name_input)
}

resource "azurerm_resource_group" "rg" {
  # Use the processed lowercase name
  name     = local.resource_group_name_processed
  location = "East US"
  tags = {
    Name = upper(local.resource_group_name_processed)  # Convert the name to uppercase for the tag
  }
}
