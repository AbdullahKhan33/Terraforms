# Environment-specific variables for the dev workspace
variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  default     = "10.0.0.0/16"
}

variable "location" {
  description = "The Azure region for resources."
  default     = "East US" # You can change the default value to your desired Azure region
}
