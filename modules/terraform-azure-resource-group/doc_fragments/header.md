# Terraform Module for Azure Resource Group

This module contains resource files and example variable definition files for creation of a Resource Group on Azure. The module can be used for creation of the pre-requisite resources for Cloudera Data Platform (CDP) Public Cloud.

## Usage

The [examples](./examples) directory has examples of Azure Resource Group creation:

* `ex01-cdp-rg` uses the minimum set of inputs to create a Azure Resource Group suitable for CDP Public Cloud.

* `ex02-cdp-existing-rg` shows an example of the lookups that take place when an existing resource group is passed to the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
