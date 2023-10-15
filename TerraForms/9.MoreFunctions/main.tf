provider "azurerm" {
  features {}
}

# Mock list of resource group names
locals {
  resource_group_names = ["dev-rg", "prod-rg", "test-rg"]
}

# Use file function to read a configuration json
locals {
  config_json = jsondecode(file("config.json"))
}

# Create a resource group for each name in the list
resource "azurerm_resource_group" "rg" {
  count    = length(local.resource_group_names)
  name     = sort(local.resource_group_names)[count.index]
  location = local.config_json.default_location
  tags     = {
    environment = upper(lookup(local.config_json.tags, local.resource_group_names[count.index], "unknown"))
  }
}

# Assuming "config.json" contains:
# {
#   "default_location": "East US",
#   "tags": {
#     "dev-rg": "development",
#     "prod-rg": "production",
#     "test-rg": "testing"
#   }
# }
