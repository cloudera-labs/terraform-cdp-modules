# Terraform Module for AWS Network Firewall

This module contains resource files and example variable definition files to create and configure an AWS Network Firewall. This module can assist with a fully private Cloudera on AWS deployment, where the Cloudera environment is connected to a networking VPC running the firewall.

## Usage

The [examples](./examples) directory has example of using this module:

* `ex01-minimal_inputs` demonstrates how this module can be used to within a networking VPC. The [terraform-aws-nfw-vpc](../../../terraform-aws-nfw-vpc/README.md) module is also used as part of this example.

The sample `terraform.tfvars.sample` describes the required inputs for the example.
