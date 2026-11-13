# Terraform Module for Azure Resource Group

This module contains resource files and example variable definition files for creating an Azure Resource Group. The module can create prerequisite resources for Cloudera on Azure.

## Usage

The [examples](./examples) directory has examples of Azure Resource Group creation:

* `ex01-cdp-rg` uses the minimum set of inputs to create an Azure Resource Group suitable for Cloudera on Azure.

* `ex02-cdp-existing-rg` shows an example of the lookups that take place when an existing resource group is passed to the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
