Alright, let's focus on using Terraform to create an Azure Virtual Machine (compute resource). 

To provision a VM in Azure using Terraform, follow these steps:

1. **Provider Configuration**:
   
   Set up the Azure provider. You'll first need to authenticate to Azure. This can be done using a service principal or other methods like Azure CLI.

   ```hcl
   provider "azurerm" {
     features {}
   }
   ```

2. **Define a Resource Group**:

   Azure resources need to be associated with a resource group.

   ```hcl
   resource "azurerm_resource_group" "example" {
     name     = "example-resources"
     location = "West US"
   }
   ```

3. **Define a Virtual Network**:

   A VM typically resides in a virtual network.

   ```hcl
   resource "azurerm_virtual_network" "example" {
     name                = "example-network"
     address_space       = ["10.0.0.0/16"]
     location            = azurerm_resource_group.example.location
     resource_group_name = azurerm_resource_group.example.name
   }
   ```

4. **Define a Subnet within the Virtual Network**:

   ```hcl
   resource "azurerm_subnet" "example" {
     name                 = "example-subnet"
     resource_group_name  = azurerm_resource_group.example.name
     virtual_network_name = azurerm_virtual_network.example.name
     address_prefix       = "10.0.1.0/24"
   }
   ```

5. **Create a Network Interface**:

   This will allow your VM to communicate over the network.

   ```hcl
   resource "azurerm_network_interface" "example" {
     name                = "example-nic"
     location            = azurerm_resource_group.example.location
     resource_group_name = azurerm_resource_group.example.name

     ip_configuration {
       name                          = "internal"
       subnet_id                     = azurerm_subnet.example.id
       private_ip_address_allocation = "Dynamic"
     }
   }
   ```

6. **Create the Virtual Machine**:

   ```hcl
   resource "azurerm_linux_virtual_machine" "example" {
     name                = "example-vm"
     location            = azurerm_resource_group.example.location
     resource_group_name = azurerm_resource_group.example.name
     network_interface_ids = [azurerm_network_interface.example.id]
     size                = "Standard_F2"

     os_disk {
       caching              = "ReadWrite"
       storage_account_type = "Standard_LRS"
     }

     source_image_reference {
       publisher = "Canonical"
       offer     = "UbuntuServer"
       sku       = "18.04-LTS"
       version   = "latest"
     }

     computer_name  = "hostname"
     admin_username = "adminuser"
     admin_password = "Password1234!"
     disable_password_authentication = false
   }
   ```

7. **Initialize and Apply**:

   ```bash
   terraform init
   terraform apply
   ```

This example demonstrates a simple VM creation. In real-world scenarios, you might need to add more configurations like security rules, data disks, managed identities, etc. Always ensure that you are following best practices, especially around security (e.g., not hardcoding passwords).