# Terraform Module for Cloudera on Cloud Deployment

This module contains resource files and example variable definition files for deployment of Cloudera on cloud environment and Datalake creation on AWS, Azure or GCP.

## Usage

The [examples](./examples) directory has example Cloudera on cloud deployments:

* `ex01-aws-basic` creates a basic Cloudera on AWS deployment. This example makes use of the [terraform-cdp-aws-pre-reqs module](../terraform-cdp-aws-pre-reqs) to create the required cloud resources.

* `ex02-azure-basic` creates a basic Cloudera on Azure deployment. This example makes use of the [terraform-cdp-azure-pre-reqs module](../terraform-cdp-azure-pre-reqs) to create the required cloud resources.

* `ex03-gcp-basic` creates a basic Cloudera on GCP deployment. This example makes use of the [terraform-cdp-gcp-pre-reqs module](../terraform-cdp-gcp-pre-reqs) to create the required cloud resources.

* `ex04-aws-custom-policies` creates a Cloudera on AWS deployment using custom IAM policy documents passed as local static JSON files. This example demonstrates how to implement minimal resource access policies and makes use of the [terraform-cdp-aws-pre-reqs module](../terraform-cdp-aws-pre-reqs) to create the required cloud resources with custom policies.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.