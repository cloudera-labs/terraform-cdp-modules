# Terraform Module for Cloudera on Azure Credential Prerequisites

This module contains resource files and example variable definition files for creation of Cross Account Credential pre-requisite for Cloudera on Azure. This includes creation of a Azure Entra ID application, a client secret and a Service Principal with appropriate Role Assignments.

Support for using a pre-existing Entra Application is provided via the `existing_xaccount_app_client_id` input variable. When this is set resources are created. Instead a lookup of the details of the existing Entra ID application takes place and is returned.

## Usage

The [examples](./examples) directory has examples of Azure Resource Group creation:

* `ex01-minimal-inputs` uses the minimum set of inputs to create a Azure Entra ID Application suitable for Cloudera on Azure credential.

* `ex02-existing-app` passes a pre-existing Cross Account Application to the module. In this case no resources are created.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
