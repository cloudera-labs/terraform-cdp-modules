# Terraform Module for CDP Prerequisites

This module contains resource files and example variable definition files for creation of the pre-requisite AWS cloud resources required for Cloudera Data Platform (CDP) Public Cloud.

## Usage

The [examples](./examples) directory has example AWS Cloud Service Provider deployments for different scenarios:

* `ex01-minimal-inputs` uses the minimum set of inputs for the module.

* `ex02-existing-vpc` creates a VPC and subnets outside of the module and passes this as an additional input. CDP deployment then uses these network assets.

* `ex03-create-keypair` creates the AWS EC2 Keypair in the module caller and passes this as an additional input.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
