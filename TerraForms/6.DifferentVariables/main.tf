# Azure Provider Configuration
provider "azurerm" {
  features {}
}

# Input Variables
variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
  default     = "walmart-resource-group"
}

variable "location" {
  description = "The Azure Region in which resources should be created"
  type        = string
  default     = "East US"
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
  default     = "walmart-vnet"
}

variable "address_space" {
  description = "Address range for the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

# Local Values
locals {
  vnet_tags = {
    ManagedBy    = "Terraform"
    Environment  = "Dev"
    Brand        = "Walmart"
  }
}

# Azure Resource Group for Walmart
resource "azurerm_resource_group" "walmart_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure Virtual Network for Walmart
resource "azurerm_virtual_network" "walmart_vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.walmart_rg.location
  resource_group_name = azurerm_resource_group.walmart_rg.name
  address_space       = var.address_space
  tags                = local.vnet_tags
}

# Output Values
output "walmart_vnet_id" {
  value       = azurerm_virtual_network.walmart_vnet.id
  description = "The ID of the Walmart branded Virtual Network"
}

output "walmart_vnet_location" {
  value       = azurerm_virtual_network.walmart_vnet.location
  description = "The Azure Region where the Walmart branded Virtual Network is located"
}
