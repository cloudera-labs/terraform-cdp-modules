# Terraform Module for AWS Network Firewall

This module contains resource files and example variable definition files to create and configure an AWS Network Firewall. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a fully private networking configuration where the CDP Environment is connected to a Networking VPC running the Firewall.

## Usage

The [examples](./examples) directory has example of using this module:

* `ex01-minimal_inputs` demonstrates how this module can be used to within a networking VPC. The [terraform-aws-nfw-vpc](../../../terraform-aws-nfw-vpc/README.md) module is also used as part of this example.

The sample `terraform.tfvars.sample` describes the required inputs for the example.
