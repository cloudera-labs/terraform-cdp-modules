# Terraform Module for Azure Bastion Host

This module contains resource files and example variable definition files to create a Bastion Host on Azure. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a secure environment, where the CDP Environment requires a Bastion host.

## Usage

The [examples](./examples) directory has example Azure Cloud Service Provider deployments for different scenarios:

* `ex01-minimal_inputs` demonstrates how this module can be used to create a Bastion Host in a Vnet.

The sample `terraform.tfvars.sample` describes the required inputs for the example.
