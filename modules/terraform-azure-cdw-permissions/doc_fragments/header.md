# Terraform Module for the Azure Managed Identity for Cloudera Data Warehouse

This module contains resource files and example variable definition files for creating the Azure Kubernetes Service managed identity required for Cloudera Data Warehouse. This requirement is described [in the Cloudera Data Warehouse documentation](https://docs.cloudera.com/data-warehouse/cloud/azure-environments/topics/dw-azure-environment-requirements-checklist.html#pnavId5).

## Usage

The [examples](./examples) directory has example Azure AKS Managed Identity creation:

* `ex01-aks_managed_identity` uses a set of inputs for the module.

An example `terraform.tfvars.sample` values file is included to show input variable values.
