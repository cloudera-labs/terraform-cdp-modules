<!-- BEGIN_TF_DOCS -->
# Terraform Module for Azure Resource Group

This module contains resource files and example variable definition files for creation of a Resource Group on Azure. The module can be used for creation of the pre-requisite resources for Cloudera Data Platform (CDP) Public Cloud.

## Usage

The [examples](./examples) directory has examples of Azure Resource Group creation:

* `ex01-cdp-rg` uses the minimum set of inputs to create a Azure Resource Group suitable for CDP Public Cloud.

* `ex02-cdp-existing-rg` shows an example of the lookups that take place when an existing resource group is passed to the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
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
| [azurerm_resource_group.rmgp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rmgp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Region which Resource Group will be created | `string` | `null` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | Flag to specify if the Resource Group should be created. Otherwise data sources will be used to lookup details of existing resources. | `bool` | `true` | no |
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name) | Name of existing VNet. Required if create\_resource\_group is false. | `string` | `null` | no |
| <a name="input_resourcegroup_name"></a> [resourcegroup\_name](#input\_resourcegroup\_name) | Resource Group name | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provisioned resources | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | Azure Resource Group ID |
| <a name="output_resource_group_location"></a> [resource\_group\_location](#output\_resource\_group\_location) | Azure Resource Group Location |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Azure Resource Group Name |
<!-- END_TF_DOCS -->