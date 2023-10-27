# Terraform Module for AWS Transit Gateway

This module contains resource files and example variable definition files for creation of AWS Transity Gateway (TGW) and attaching a specified list of VPCs via the TGW. This module also updates both the Transit Gateway and VPC route tables. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a fully private networking configuration where a CDP VPC and Networking VPC are connected using the Transit Gateway.

## Usage

The [examples](./examples) directory has example of using this module:

* `ex01-vpc-tgw-attach` demonstrates how this module can be used to use a Transit Gateway to attach a private CDP VPC with a dedicated networking VPC. The [terraform-aws-vpc](../../../terraform-aws-vpc/README.md) module is also used as part of this example.

The README and sample `terraform.tfvars.sample` describe how to use the example.
