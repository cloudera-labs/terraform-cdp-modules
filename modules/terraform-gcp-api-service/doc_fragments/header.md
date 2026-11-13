# Terraform Module for GCP API Services

This module contains resource files and example variable definition files for enabling and checking the GCP API services required for Cloudera on GCP.

The module can either enable the required APIs (when `enable_apis = true`) or perform a data source lookup to verify that the APIs are already enabled (the default behavior when `enable_apis = false`).

## Usage

The [examples](./examples) directory has example configurations for different scenarios:

* `ex01-enable-apis` uses the module to enable the GCP APIs required for a Cloudera deployment.

* `ex02-check-apis` shows an example of the lookup-only mode to check if APIs are already enabled.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
