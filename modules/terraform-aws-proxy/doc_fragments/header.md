# Terraform Module for AWS Transit Gateway

This module contains resource files and example variable definition files to create and configure and EC2 Auto-Scaling Group to create a highly available Squid Proxy service. A Network Load Balancer is also created to forward traffic to the proxy instances. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a fully private networking configuration where the CDP Environment uses a proxy configuration via the Network Load Balancer.

## Usage

The [examples](./examples) directory has example of using this module:

* `ex01-minimal_inputs` demonstrates how this module can be used to create Squid proxy instances and NLB in a networking VPC. The [terraform-aws-vpc](../../../terraform-aws-vpc/README.md) module is also used as part of this example.

The sample `terraform.tfvars.sample` describes the required inputs for the example.
