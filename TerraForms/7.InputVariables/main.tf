# Azure Provider Configuration
provider "azurerm" {
  features {}
}

# Input Variables

## String
variable "walmart_resource_group_name" {
  description = "The name of the Walmart Azure Resource Group"
  type        = string
  default     = "walmart-resource-group"
}

## Number
variable "walmart_max_instances" {
  description = "Maximum number of instances for Walmart"
  type        = number
  default     = 5
}

## Bool
variable "walmart_enable_logging" {
  description = "Flag to enable or disable logging for Walmart resources"
  type        = bool
  default     = true
}

## List
variable "walmart_availability_zones" {
  description = "List of availability zones for Walmart resources"
  type        = list(string)
  default     = ["1", "2", "3"]
}

## Set
variable "walmart_unique_zones" {
  description = "Set of unique zones for Walmart resources"
  type        = set(string)
  default     = ["walmart-zoneA", "walmart-zoneB", "walmart-zoneC"]
}

## Map
variable "walmart_tags" {
  description = "Tags to apply to Walmart resources"
  type        = map(string)
  default     = {
    Environment = "Walmart-Dev"
    Owner       = "Walmart-Ops"
    Brand       = "Walmart"
  }
}

## Object
variable "walmart_vnet_settings" {
  description = "Settings for the Walmart virtual network"
  type = object({
    name         = string
    address_space = list(string)
  })
  default = {
    name         = "walmart-vnet"
    address_space = ["10.0.0.0/16"]
  }
}

## Tuple
variable "walmart_location_and_sku" {
  description = "Tuple containing the Azure location and SKU for Walmart resources"
  type        = tuple([string, string])
  default     = ["East US", "Walmart-Standard_DS1_v2"]
}

# Resource: Illustrating the usage of variables with Walmart branding
resource "azurerm_resource_group" "walmart_rg" {
  name     = var.walmart_resource_group_name
  location = var.walmart_location_and_sku[0]  # Using the location from our tuple variable
  tags     = var.walmart_tags
}

# Note: This structure is designed to illustrate variable types in the context of Walmart for Azure.
# In a real-world scenario, you'd use these variables across various resources and configurations.
