<!-- BEGIN_TF_DOCS -->
# Terraform Module for Cloudera on Azure Credential Prerequisites

This module contains resource files and example variable definition files for creation of Cross Account Credential pre-requisite for Cloudera on Azure. This includes creation of a Azure Entra ID application, a client secret and a Service Principal with appropriate Role Assignments.

Support for using a pre-existing Entra Application is provided via the `existing_xaccount_app_client_id` input variable. When this is set resources are created. Instead a lookup of the details of the existing Entra ID application takes place and is returned.

## Usage

The [examples](./examples) directory has examples of Azure Resource Group creation:

* `ex01-minimal-inputs` uses the minimum set of inputs to create a Azure Entra ID Application suitable for Cloudera on Azure credential.

* `ex02-existing-app` passes a pre-existing Cross Account Application to the module. In this case no resources are created.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.46.0, < 4.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | >= 2.46.0, < 4.0.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.cdp_xaccount_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_password.cdp_xaccount_app_password](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password) | resource |
| [azuread_service_principal.cdp_xaccount_app_sp](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.cdp_xaccount_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_application.existing_xaccount_app](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application) | data source |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.sub_details](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Azure Subscription ID | `string` | `null` | no |
| <a name="input_existing_xaccount_app_client_id"></a> [existing\_xaccount\_app\_client\_id](#input\_existing\_xaccount\_app\_client\_id) | Client ID of existing Azure AD Application for Cloudera Cross Account. If set then no application or SPN resources are created. | `string` | `null` | no |
| <a name="input_existing_xaccount_app_pword"></a> [existing\_xaccount\_app\_pword](#input\_existing\_xaccount\_app\_pword) | Password of existing Azure AD Application for Cloudera Cross Account. If set then no application or SPN resources are created. | `string` | `null` | no |
| <a name="input_xaccount_app_name"></a> [xaccount\_app\_name](#input\_xaccount\_app\_name) | Cross account application name within Azure Active Directory | `string` | `null` | no |
| <a name="input_xaccount_app_owners"></a> [xaccount\_app\_owners](#input\_xaccount\_app\_owners) | List principals object IDs that will be granted ownership of the Cross Account application. If not specified the executing principal will be set as the owner. | `list(string)` | `null` | no |
| <a name="input_xaccount_app_password_end_date_relative"></a> [xaccount\_app\_password\_end\_date\_relative](#input\_xaccount\_app\_password\_end\_date\_relative) | The relative duration for which the password (client secret) for the Cross Account application is valid. | `string` | `"17520h"` | no |
| <a name="input_xaccount_app_role_assignments"></a> [xaccount\_app\_role\_assignments](#input\_xaccount\_app\_role\_assignments) | List of Role Assignments for the Cross Account Service Principal. If scope is not specified then scope is set to var.azure\_subscription\_id | <pre>list(object({<br/>    role        = string<br/>    description = string<br/>    scope       = optional(string)<br/>    })<br/>  )</pre> | <pre>[<br/>  {<br/>    "description": "Contributor Role to Cross Account Service Principal at Subscription Level",<br/>    "role": "Contributor"<br/>  }<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_xaccount_app"></a> [azure\_xaccount\_app](#output\_azure\_xaccount\_app) | Full details for the Azure AD Cross Account Application |
| <a name="output_azure_xaccount_app_client_id"></a> [azure\_xaccount\_app\_client\_id](#output\_azure\_xaccount\_app\_client\_id) | Client ID for the Azure AD Cross Account Application |
| <a name="output_azure_xaccount_app_pword"></a> [azure\_xaccount\_app\_pword](#output\_azure\_xaccount\_app\_pword) | Password for the Azure AD Cross Account Application |
| <a name="output_azure_xaccount_service_principal_id"></a> [azure\_xaccount\_service\_principal\_id](#output\_azure\_xaccount\_service\_principal\_id) | ID for the Azure AD Cross Account Service Principal |
<!-- END_TF_DOCS -->