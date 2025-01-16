# Terraform Module for AWS VPC suitable for hosting AWS Network Firewall

This module contains resource files and example variable definition files for creation of the Virtual Private Cloud (VPC) suitable for running a Firewall in a distributed architecture on AWS. It creates subnets across multiple availability zones for NAT gateways, the Network Firewall and for a Transit Gateway connections to other VPCs.

The module can be used for creation of the a networking VPC which runs the AWS Network Firewall and connects to a Cloudera on cloud full-private deployment.

## Usage

The [examples](./examples) directory has example creating a VPC:

* `ex01-fw-vpc` uses the minimum set of inputs to create a AWS VPC suitable for hosting the AWS Network Firewall.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
