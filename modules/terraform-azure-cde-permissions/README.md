<!-- BEGIN_TF_DOCS -->
# Terraform Module for Azure Managed Identity for CDE

This module contains resource files and example variable definition files for creation of the Azure managed identity  required for the Cloudera Data Engineering (CDE) service. This requirement is described [in this section](https://docs.cloudera.com/data-engineering/cloud/enable-data-engineering/topics/cde-creating-user-assigned-managed-identities.html) of the CDE documentation.

## Usage

The [examples](./examples) directory has example Azure Managed Identity creation:

* `ex01-cde_managed_identity` uses a set of inputs for the module.

An example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.cdp_cde_container_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.cdp_cde](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_storage_account.log_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_storage_container.log_storage_container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_container) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_cde_managed_identity_name"></a> [azure\_cde\_managed\_identity\_name](#input\_azure\_cde\_managed\_identity\_name) | Name of the Managed Identity for the AKS Credential | `string` | n/a | yes |
| <a name="input_azure_log_storage_account_name"></a> [azure\_log\_storage\_account\_name](#input\_azure\_log\_storage\_account\_name) | Name of the Azure Storage Account used for CDP Logs | `string` | n/a | yes |
| <a name="input_azure_log_storage_container_name"></a> [azure\_log\_storage\_container\_name](#input\_azure\_log\_storage\_container\_name) | Name of the Azure Storage Container used for CDP Logs | `string` | n/a | yes |
| <a name="input_azure_resource_group_name"></a> [azure\_resource\_group\_name](#input\_azure\_resource\_group\_name) | Azrue Resource Group for CDP environment. | `string` | n/a | yes |
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Region which Cloud resources will be created | `string` | `null` | no |
| <a name="input_cde_container_role_assignments"></a> [cde\_container\_role\_assignments](#input\_cde\_container\_role\_assignments) | List of Role Assignments for the CDE Managed Identity at Log Storage Container scope. | <pre>list(object({<br/>    role        = string<br/>    description = optional(string)<br/>    })<br/>  )</pre> | <pre>[<br/>  {<br/>    "description": "Assign Storage Blob Data Contributor to CDP Log Storage Container to CDE Managed Identity",<br/>    "role": "Storage Blob Data Contributor"<br/>  }<br/>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provised resources | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_cde_managed_identity_id"></a> [azure\_cde\_managed\_identity\_id](#output\_azure\_cde\_managed\_identity\_id) | ID of the Azure CDE managed identity |
| <a name="output_azure_subscription_id"></a> [azure\_subscription\_id](#output\_azure\_subscription\_id) | Subscription ID where the Azure CDE managed identity is created |
<!-- END_TF_DOCS -->