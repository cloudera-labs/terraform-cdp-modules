# Terraform Module for AWS Transit Gateway

This module contains resource files and example variable definition files for creating an AWS Transit Gateway and attaching a specified list of VPCs. This module also updates the Transit Gateway and VPC route tables. It can assist with a fully private Cloudera on AWS deployment, where the Cloudera VPC and networking VPC are connected using the Transit Gateway.

## Usage

The [examples](./examples) directory has example of using this module:

* `ex01-vpc-tgw-attach` demonstrates how this module can create a Transit Gateway to attach a private Cloudera VPC to a dedicated networking VPC. The [terraform-aws-vpc](../../../terraform-aws-vpc/README.md) module is also used in this example.

The README and sample `terraform.tfvars.sample` describe how to use the example.
