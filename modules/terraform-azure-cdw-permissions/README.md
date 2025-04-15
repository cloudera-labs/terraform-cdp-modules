<!-- BEGIN_TF_DOCS -->
# Terraform Module for Azure AKS Managed Identity for CDW

This module contains resource files and example variable definition files for creation of the Azure Kubernetes Service (AKS) managed identity required for the Cloudera Data Warehouse (CDW) service. This requirement is described [in this section](https://docs.cloudera.com/data-warehouse/cloud/azure-environments/topics/dw-azure-environment-requirements-checklist.html#pnavId5) of the CDW documentation.

## Usage

The [examples](./examples) directory has example Azure AKS Managed Identity creation:

* `ex01-aks_managed_identity` uses a set of inputs for the module.

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
| [azurerm_role_assignment.cdp_cdw_aks_cred_storage_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cdp_cdw_aks_cred_subscription_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.cdp_cdw_aks_cred](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_storage_account.data_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_aks_credential_managed_identity_name"></a> [azure\_aks\_credential\_managed\_identity\_name](#input\_azure\_aks\_credential\_managed\_identity\_name) | Name of the Managed Identity for the AKS Credential | `string` | n/a | yes |
| <a name="input_azure_data_storage_account"></a> [azure\_data\_storage\_account](#input\_azure\_data\_storage\_account) | Name of the Azure Storage Account used for CDP Data | `string` | n/a | yes |
| <a name="input_azure_resource_group_name"></a> [azure\_resource\_group\_name](#input\_azure\_resource\_group\_name) | Azrue Resource Group for CDP environment. | `string` | n/a | yes |
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Region which Cloud resources will be created | `string` | `null` | no |
| <a name="input_cdw_aks_cred_storage_role_assignments"></a> [cdw\_aks\_cred\_storage\_role\_assignments](#input\_cdw\_aks\_cred\_storage\_role\_assignments) | List of Role Assignments for the AKS Credential at Data Storage Account scope. | <pre>list(object({<br/>    role        = string<br/>    description = optional(string)<br/>    })<br/>  )</pre> | <pre>[<br/>  {<br/>    "description": "Assign Storage Blob Data Owner assignment to CDP Data Storage Container to AKS Credential",<br/>    "role": "Storage Blob Data Owner"<br/>  }<br/>]</pre> | no |
| <a name="input_cdw_aks_cred_subscription_role_assignments"></a> [cdw\_aks\_cred\_subscription\_role\_assignments](#input\_cdw\_aks\_cred\_subscription\_role\_assignments) | List of Role Assignments for the AKS Credential at subscription scope | <pre>list(object({<br/>    role        = string<br/>    description = optional(string)<br/>    })<br/>  )</pre> | <pre>[<br/>  {<br/>    "description": "Assign Contributor Role to AKS Credential",<br/>    "role": "Contributor"<br/>  }<br/>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provised resources | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_aks_managed_identity_id"></a> [azure\_aks\_managed\_identity\_id](#output\_azure\_aks\_managed\_identity\_id) | ID of the Azure AKS managed identity |
| <a name="output_azure_subscription_id"></a> [azure\_subscription\_id](#output\_azure\_subscription\_id) | Subscription ID where the Azure AKS managed identity is created |
<!-- END_TF_DOCS -->