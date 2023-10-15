 Terraform functions allow you to manipulate and transform data within your configurations. Here's an overview of some common numeric and string functions, along with examples:

### 1. Numeric Functions:

#### a) `abs`:
- Returns the absolute value of a number.
- Example: `abs(-10)` returns `10`.

#### b) `ceil`:
- Returns the smallest whole number that is greater than or equal to the given number.
- Example: `ceil(4.6)` returns `5`.

#### c) `floor`:
- Returns the largest whole number that is less than or equal to the given number.
- Example: `floor(4.6)` returns `4`.

#### d) `max`:
- Returns the maximum value from a list of numbers.
- Example: `max(1, 5, 7)` returns `7`.

#### e) `min`:
- Returns the minimum value from a list of numbers.
- Example: `min(1, 5, 7)` returns `1`.

### 2. String Functions:

#### a) `substr`:
- Extracts a substring from a string by specifying a start index and a length.
- Example: `substr("terraform", 0, 4)` returns `terr`.

#### b) `lower`:
- Returns the given string converted to lowercase.
- Example: `lower("TERRAFORM")` returns `terraform`.

#### c) `upper`:
- Returns the given string converted to uppercase.
- Example: `upper("terraform")` returns `TERRAFORM`.

#### d) `trimspace`:
- Removes any space characters from the start and end of the given string.
- Example: `trimspace("  terraform  ")` returns `terraform`.

#### e) `replace`:
- Replaces occurrences of a substring within a string.
- Example: `replace("terraXform", "X", "f")` returns `terraform`.

---

### Using Functions in Terraform with Azure:

Let's integrate some of these functions in an example Terraform configuration for Azure:

```hcl
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
```

In this Azure example, we're defining an input variable for a resource group name which could be provided in uppercase. We use the `lower` function to ensure Azure resources, which often have case requirements, get a lowercase string. We then use the `upper` function to provide an uppercase tag for demonstration.