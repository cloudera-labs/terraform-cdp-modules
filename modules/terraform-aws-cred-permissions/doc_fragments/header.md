# Terraform Module for Cloudera on AWS Credential Prerequisites

This module contains resource files and example variable definition files for creation of the Cloudera Data Platform (CDP) Public Cloud Cross Account Credential pre-requisite on AWS.

Support for using a pre-existing Cross Account Role is provided via the `existing_xaccount_role_name` input variable. When this is set no policy or role resources are created. Instead a lookup of the details of the existing role takes place and the role ARN is returned.

## Usage

The [examples](./examples) directory has the following examples for Cross Account Credentials on AWS:

* `ex01-minimal-inputs` uses the minimum set of inputs for the module where the Cross Account policy and roles are to be created.

* `ex02-existing-role` passes a pre-existing Cross Account role to the module. In this case no resources are created.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
