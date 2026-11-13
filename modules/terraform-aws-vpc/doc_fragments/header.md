# Terraform Module for AWS VPC

This module contains resource files and example variable definition files for creating an Amazon Virtual Private Cloud (VPC). The module can create prerequisite resources for Cloudera on AWS. It can also create a generic VPC for use as a networking VPC in a private Cloudera environment.

## Usage

The [examples](./examples) directory has example AWS VPCs for different scenarios:

* `ex01-cdp-vpc` uses the minimum set of inputs to create an AWS VPC suitable for Cloudera on AWS.

* `ex02-network-vpc` created a generic network VPC.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
