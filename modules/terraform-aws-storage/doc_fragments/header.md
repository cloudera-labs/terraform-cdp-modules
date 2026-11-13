# Terraform Module for AWS S3 Storage

This module contains resource files and example variable definition files for creating and managing the AWS S3 storage buckets required for Cloudera on AWS. The module creates S3 buckets for the three storage roles (data, log, backup) with internal deduplication when multiple roles resolve to the same bucket name. Public access blocks, optional versioning, and KMS encryption are supported.

Support for using pre-existing S3 buckets is provided via the `create_data_storage`, `create_log_storage` and `create_backup_storage` input variables. When set to `false`, the corresponding `existing_*_bucket` variable is used to perform a data source lookup of the existing bucket. Outputs remain consistent regardless of the create or reuse path.

## Usage

The [examples](./examples) directory has examples of using this module:

* `ex01-minimal_inputs` demonstrates how this module can be used to create S3 storage buckets with minimum required inputs.
* `ex02-reuse_existing` demonstrates how to use existing S3 buckets with this module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
