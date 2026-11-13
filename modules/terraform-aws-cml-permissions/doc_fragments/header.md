# Terraform Module for AWS IAM Permissions for Cloudera AI

This module contains resource files and example variable definition files for creating the AWS IAM policies required for Cloudera AI backup and restore. This requirement is described [in the Cloudera AI documentation](https://docs.cloudera.com/machine-learning/cloud/workspaces/topics/ml-backup-restore-prerequisites.html).

## Usage

The [examples](./examples) directory has an example AWS IAM policy creation on AWS:

* `ex01-minimal-inputs` uses the minimum set of inputs for the module.

An example `terraform.tfvars.sample` values file is included to show input variable values.
