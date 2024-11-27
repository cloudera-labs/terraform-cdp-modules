<!-- BEGIN_TF_DOCS -->
# Terraform Module for Azure Private Endpoints

This module contains resource files and example variable definition files for creation of the Azure private endpoints to storage accounts for specified subnets.

## Usage

The [examples](./examples) directory has example Azure Cloud Service Provider deployments for different scenarios:

* `ex01-minimal_inputs` uses the minimal set of inputs for the module.

An example `terraform.tfvars.sample` values file is included to show input variable values.

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
| [azurerm_private_dns_zone.stor_privatednszone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.stor_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.private_endpoints](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Region for the private endpoints | `string` | n/a | yes |
| <a name="input_private_endpoint_prefix"></a> [private\_endpoint\_prefix](#input\_private\_endpoint\_prefix) | Shorthand name for the private endpoint resources. Used in resource descriptions | `string` | n/a | yes |
| <a name="input_private_endpoint_storage_account_ids"></a> [private\_endpoint\_storage\_account\_ids](#input\_private\_endpoint\_storage\_account\_ids) | List of storage account ids to which private endpoints are created | `list(string)` | n/a | yes |
| <a name="input_private_endpoint_target_subnet_ids"></a> [private\_endpoint\_target\_subnet\_ids](#input\_private\_endpoint\_target\_subnet\_ids) | List of subnet ids to which private endpoints are created | `list(string)` | n/a | yes |
| <a name="input_resourcegroup_name"></a> [resourcegroup\_name](#input\_resourcegroup\_name) | Pre-existing Resource Group Name | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Pre-existing Vnet name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to VPC resources. Only used when create\_vpc is true. | `map(any)` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->