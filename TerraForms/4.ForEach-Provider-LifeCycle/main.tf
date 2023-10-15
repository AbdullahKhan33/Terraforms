provider "azurerm" {
  features {}
}

variable "resource_groups" {
  description = "A map of resource group names and their respective locations"
  default = {
    rg1 = "East US",
    rg2 = "West US",
    rg3 = "West Europe"
  }
}

resource "azurerm_resource_group" "example" {
  # Using for_each with a map
  for_each = var.resource_groups

  name     = each.key
  location = each.value

  lifecycle {
    prevent_destroy = true  # This will prevent the resource from being destroyed
  }
}

output "resource_group_names" {
  value = [for rg in azurerm_resource_group.example : rg.name]
}
