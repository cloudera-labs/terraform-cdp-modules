# Terraform Module for AWS VPC

This module contains resource files and example variable definition files for creation of the Virtual Private Cloud (VPC) on AWS. The module can be used for creation of the pre-requisite resources for Cloudera Data Platform (CDP) Public Cloud. It is also possible to use this module to create a more generic VPC - this can be used for as a networking VPC in a private CDP environment.

## Usage

The [examples](./examples) directory has example AWS VPCs for different scenarios:

* `ex01-cdp-vpc` uses the minimum set of inputs to create a AWS VPC suitable for CDP Public Cloud.

* `ex02-network-vpc` created a generic network VPC.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
