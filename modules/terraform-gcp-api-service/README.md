<!-- BEGIN_TF_DOCS -->
# Terraform Module for GCP API Services

This module contains resource files and example variable definition files for enabling and checking the GCP API services required for Cloudera on GCP.

The module can either enable the required APIs (when `enable_apis = true`) or perform a data source lookup to verify that the APIs are already enabled (the default behavior when `enable_apis = false`).

## Usage

The [examples](./examples) directory has example configurations for different scenarios:

* `ex01-enable-apis` uses the module to enable the GCP APIs required for a Cloudera deployment.

* `ex02-check-apis` shows an example of the lookup-only mode to check if APIs are already enabled.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 6.12 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_service.cdp_api_service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [google_project_service.cdp_api_service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project_service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_services"></a> [api\_services](#input\_api\_services) | List of GCP API services to enable or check. Defaults to the APIs required for Cloudera CDP deployment. | `list(string)` | <pre>[<br/>  "compute.googleapis.com",<br/>  "iam.googleapis.com",<br/>  "iamcredentials.googleapis.com",<br/>  "servicenetworking.googleapis.com",<br/>  "sqladmin.googleapis.com",<br/>  "storage.googleapis.com"<br/>]</pre> | no |
| <a name="input_disable_dependent_services"></a> [disable\_dependent\_services](#input\_disable\_dependent\_services) | Flag to control whether services that are enabled and which depend on the service being disabled should also be disabled when the resource is destroyed. Only relevant if disable\_on\_destroy is true. | `bool` | `false` | no |
| <a name="input_disable_on_destroy"></a> [disable\_on\_destroy](#input\_disable\_on\_destroy) | Flag to control whether the API services should be disabled when the resource is destroyed. Defaults to false to avoid accidentally breaking other services in the project. | `bool` | `false` | no |
| <a name="input_enable_apis"></a> [enable\_apis](#input\_enable\_apis) | Flag to specify if the GCP APIs should be enabled. When false (default) only a data source lookup is performed to check if the APIs are already enabled. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_service_status"></a> [api\_service\_status](#output\_api\_service\_status) | Map of GCP API service names to their details. A successful lookup confirms the API is enabled. |
<!-- END_TF_DOCS -->