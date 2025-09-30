# Terraform Module for CDP Prerequisites on Azure

This module contains resource files and example variable definition files for creation of the pre-requisite Azure cloud resources required for Cloudera Data Platform (CDP) Public Cloud.

## Usage

The [examples](./examples) directory has example Azure Cloud Service Provider deployments for different scenarios:

* `ex01-minimal-inputs` uses the minimum set of inputs for the module.

* `ex02-existing-rg` uses a pre-existing Azure resource group.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
