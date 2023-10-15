Of course, I understand. Let's simplify this.

We'll set up a basic example where we'll just create a Resource Group in Azure using Terraform.

**1. Install Terraform**

First, if you haven’t installed Terraform, download and install it from [the official website](https://www.terraform.io/downloads.html).

**2. Setup Azure CLI**

Ensure you have the Azure CLI installed. If not, install it from [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

Log in to Azure:
```
az login
```

**3. Set up the Terraform Configuration**

a. Create a new directory for your Terraform files:
```
mkdir azure-terraform && cd azure-terraform
```

b. Create a `main.tf` file and add the following:

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "West Europe"
}
```

**4. Initialize Terraform and Apply**

In the directory with your `main.tf` file:

a. Initialize the Terraform directory:
```
terraform init
```

b. Plan the deployment:
```
terraform plan
```

c. If everything looks good, apply the changes:
```
terraform apply
```

You'll be prompted to confirm that you want to make the changes. Type `yes` and hit enter.

Once it completes, you should have a new Resource Group named `example-resource-group` in the `West Europe` Azure region.

Remember, Terraform stores the current state of resources in a file named `terraform.tfstate`. If you decide you no longer want the resources, you can remove them with `terraform destroy`.


# First we are going to deploy resources in our networking subscription
# Be sure to select the networking subscription for your subname
az account show