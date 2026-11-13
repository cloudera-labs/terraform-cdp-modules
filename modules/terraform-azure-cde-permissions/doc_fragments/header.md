# Terraform Module for the Azure Managed Identity for Cloudera Data Engineering

This module contains resource files and example variable definition files for creating the Azure managed identity required for Cloudera Data Engineering. This requirement is described [in the Cloudera Data Engineering documentation](https://docs.cloudera.com/data-engineering/cloud/enable-data-engineering/topics/cde-creating-user-assigned-managed-identities.html).

## Usage

The [examples](./examples) directory has example Azure Managed Identity creation:

* `ex01-cde_managed_identity` uses a set of inputs for the module.

An example `terraform.tfvars.sample` values file is included to show input variable values.
