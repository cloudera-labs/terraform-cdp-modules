# Terraform Module for CDP Deployment

This module contains resource files and example variable definition files for deployment of Cloudera Data Platform (CDP) Public Cloud environment and Datalake creation on AWS or Azure.

## Usage

The [examples](./examples) directory has example CDP deployments:

* `ex01-aws-basic` creates a basic CDP deployment on AWS. This example makes use of the p[terraform-cdp-aws-pre-reqs module](../terraform-cdp-aws-pre-reqs) to create the required cloud resources.

* `ex02-azure-basic` creates a basic CDP deployment on Azure. This example makes use of the [terraform-cdp-azure-pre-reqs module](../terraform-cdp-azure-pre-reqs) to create the required cloud resources.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
