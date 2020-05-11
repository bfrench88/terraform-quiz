# Terraform Quiz

The following terraform includes the following modules:

1. Resource Group - This will create an Azure resource group
2. Network - This will create an Azure Virtual network space, subnets are created within the VM module
3. VM - This module will create the following:
    1. Subnet
    2. NSG
    3. Virtual machine
    4. Additional drives

## Variables

A mixture of variables is used in the repository, some modules have variables.tf files which include hardcoded values. A overal tfvars file is also used in the root.

# Structure

Directory structure is as follows:

```
terraform-quiz
├── main.tf
├── modules
│   ├── network
│   │   ├── output.tf
│   │   ├── terraform.tf
│   │   └── variables.tf
│   ├── resourcegroup
│   │   ├── output.tf
│   │   ├── terraform.tf
│   │   └── variables.tf
│   └── vm
│       ├── output.tf
│       ├── terraform.tf
│       └── variables.tf
├── provider.tf
├── readme.md
├── terraform.tfvars
├── variables.tf
└── versions.tf
```
# Quiz

This quiz is used to test the following

1. Test your understanding of GIT flow
2. Test your understanding of Terraform structure
3. Test your understanding of Terraform functions

## Objective

Fix the issues with the Terraform to allow it to create 3 virtual machines in the North Europe region of Azure.

# Tips

The following commands will be helpful

```
terraform init -backend=false
terraform validate
terraform plan
```