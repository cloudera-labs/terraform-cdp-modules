# Terraform Module for AWS Ingress (Security Groups)

This module contains resource files and example variable definition files for creating and managing the Default and Knox AWS security groups for Cloudera on cloud deployments.

Support for using a pre-existing Security Groups is provided via the `existing_default_security_group_name` and `existing_knox_security_group_name` input variables. When this is set no security group resources are created. Instead a lookup of the details of the existing security group takes place and the ID is returned.

## Usage

The [examples](./examples) directory has example of using this module:

* `ex01-minimal_inputs` demonstrates how this module can be used to create security groups with minimum required inputs. The [terraform-aws-vpc](../../../terraform-aws-vpc/README.md) module is also used as part of this example.
* `ex02-existing_sgs` demonstrates how to use existing security groups with this module.

The README and sample `terraform.tfvars.sample` describe how to use the example.
