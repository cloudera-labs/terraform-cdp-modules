# Terraform Module for Azure VNet

This module contains resource files and example variable definition files for creating an Azure Virtual Network. The module can create prerequisite resources for Cloudera on Azure.

## Usage

The [examples](./examples) directory has example Azure VNETs for different scenarios:

* `ex01-cdp-vnet` uses the minimum set of inputs to create an Azure VNet suitable for Cloudera on Azure.

* `ex02-cdp-existing-vnet` shows an example of the lookups that take place when an existing VNet is passed to the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
