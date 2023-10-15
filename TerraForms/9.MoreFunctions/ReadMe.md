Let's delve into collection, encoding, and filesystem functions in Terraform.

### 1. Collection Functions:

#### a) `length`:
- Returns the number of elements in a given list, map, or string.
- Example: `length(["one", "two", "three"])` returns `3`.

#### b) `list`:
- Returns a list consisting of the arguments passed to it.
- Example: `list("one", "two")` returns `["one", "two"]`.

#### c) `lookup`:
- Looks up a value in a map based on its key.
- Example: `lookup(map("key", "value"), "key", "default")` returns `value`.

#### d) `sort`:
- Returns a sorted list of the strings contained in the list.
- Example: `sort(["banana", "apple", "cherry"])` returns `["apple", "banana", "cherry"]`.

### 2. Encoding Functions:

#### a) `base64encode`:
- Returns a Base64 representation of the given string.
- Example: `base64encode("terraform")`.

#### b) `base64decode`:
- Decodes a Base64-encoded string.
- Example: `base64decode(base64encode("terraform"))` would return `"terraform"`.

#### c) `jsonencode`:
- Returns a string containing a valid JSON text representation of the given value.
- Example: `jsonencode(map("key", "value"))` would return `{"key":"value"}`.

### 3. Filesystem Functions:

#### a) `file`:
- Reads the contents of a file into a string.
- Example: `file("path/to/file.txt")` returns the content of `file.txt`.

#### b) `filebase64`:
- Reads the contents of a file and returns its Base64-encoded content.
- Example: `filebase64("path/to/binary_file")`.

#### c) `fileexists`:
- Determines whether the specified file is present.
- Example: `fileexists("path/to/file.txt")` returns `true` if the file exists.

---

### Using Functions in Terraform with Azure:

Here's a sample configuration that integrates some of these functions with Azure:

```hcl
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
```

In this Azure example:
1. We have a local list of resource group names.
2. We're reading a configuration from a `config.json` file which defines a default location and a map of tags for each resource group.
3. We're creating a set of resource groups based on our list, using functions like `length`, `sort`, `lookup`, and `upper`.
4. We're dynamically setting the location and tags based on our loaded JSON configuration.

This example demonstrates how Terraform functions can be integrated into real-world configurations, helping automate and streamline infrastructure setup.