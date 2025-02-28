# Terraform Module for Azure VNet

This module contains resource files and example variable definition files for creation of the Virtual Network (VNET) on Azure. The module can be used for creation of the pre-requisite resources for Cloudera Data Platform (CDP) Public Cloud.

## Usage

The [examples](./examples) directory has example Azure VNETs for different scenarios:

* `ex01-cdp-vnet` uses the minimum set of inputs to create a Azure VNet suitable for CDP Public Cloud.

* `ex02-cdp-existing-vnet` shows an example of the lookups that take place when an existing VNet is passed to the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
