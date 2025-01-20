# Terraform Module for AWS Bastion

This module contains resource files and example variable definition files to create a Bastion EC2 instance on AWS. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a secure environment, where the CDP Environment requires a Bastion host.

## Usage

The [examples](./examples) directory has example of using this module:

* `ex01-minimal_inputs` demonstrates how this module can be used to create a Bastion instance in a networking VPC. The [terraform-aws-vpc](../../../terraform-aws-vpc/README.md) module is also used as part of this example.

The sample `terraform.tfvars.sample` describes the required inputs for the example.
