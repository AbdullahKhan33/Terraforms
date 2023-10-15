provider "azurerm" {
  features {}
}

locals {
  description   = "This is an example resource group"
  config_value  = "SensitiveInformation"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"

  tags = {
    # Date and Time Functions
    CreatedYearMonth = formatdate("YYYY-MM", timestamp())
    CreatedTimestamp = timestamp()

    # Hash and Crypto Functions
    DescriptionHash  = sha256(local.description)
    ConfigHash       = base64sha256(local.config_value)
  }
}
