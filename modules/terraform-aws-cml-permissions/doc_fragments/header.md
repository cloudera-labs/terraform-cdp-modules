# Terraform Module for AWS IAM Permissions for CML

This module contains resource files and example variable definition files for creation of the AWS IAM policies required for the Cloudera Machine Learning (CML) backup and restore functionality. This requirement is described [in this section](https://docs.cloudera.com/machine-learning/cloud/workspaces/topics/ml-backup-restore-prerequisites.html) of the CML documentation.

## Usage

The [examples](./examples) directory has an example AWS IAM policy creation on AWS:

* `ex01-minimal-inputs` uses the minimum set of inputs for the module.

An example `terraform.tfvars.sample` values file is included to show input variable values.
