# Terraform Module for Azure Managed Identity for CDE

This module contains resource files and example variable definition files for creation of the Azure managed identity  required for the Cloudera Data Engineering (CDE) service. This requirement is described [in this section](https://docs.cloudera.com/data-engineering/cloud/enable-data-engineering/topics/cde-creating-user-assigned-managed-identities.html) of the CDE documentation.

## Usage

The [examples](./examples) directory has example Azure Managed Identity creation:

* `ex01-cde_managed_identity` uses a set of inputs for the module.

An example `terraform.tfvars.sample` values file is included to show input variable values.
