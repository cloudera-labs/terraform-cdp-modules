# Terraform Module for Azure AKS Managed Identity for CDW

This module contains resource files and example variable definition files for creation of the Azure Kubernetes Service (AKS) managed identity required for the Cloudera Data Warehouse (CDW) service. This requirement is described [in this section](https://docs.cloudera.com/data-warehouse/cloud/azure-environments/topics/dw-azure-environment-requirements-checklist.html#pnavId5) of the CDW documentation.

## Usage

The [examples](./examples) directory has example Azure AKS Managed Identity creation:

* `ex01-aks_managed_identity` uses a set of inputs for the module.

An example `terraform.tfvars.sample` values file is included to show input variable values.
