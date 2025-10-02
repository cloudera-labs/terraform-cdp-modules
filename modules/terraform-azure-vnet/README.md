<!-- BEGIN_TF_DOCS -->
# Terraform Module for Azure VNet

This module contains resource files and example variable definition files for creation of the Virtual Network (VNET) on Azure. The module can be used for creation of the pre-requisite resources for Cloudera Data Platform (CDP) Public Cloud.

## Usage

The [examples](./examples) directory has example Azure VNETs for different scenarios:

* `ex01-cdp-vnet` uses the minimum set of inputs to create a Azure VNet suitable for CDP Public Cloud.

* `ex02-cdp-existing-vnet` shows an example of the lookups that take place when an existing VNet is passed to the module.

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
| [azurerm_nat_gateway.cdp_nat_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.cdp_nat_ip_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_public_ip.cdp_nat_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet.cdp_subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.delegated_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.gateway_subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.nat_cdp_subnet_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_nat_gateway_association.nat_gateway_subnet_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_virtual_network.cdp_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_subnet.cdp_subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.delegated_subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.gateway_subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_template"></a> [deployment\_template](#input\_deployment\_template) | Deployment Pattern to use for Cloud resources and CDP | `string` | n/a | yes |
| <a name="input_resourcegroup_name"></a> [resourcegroup\_name](#input\_resourcegroup\_name) | Resource Group Name | `string` | n/a | yes |
| <a name="input_cdp_subnet_prefix"></a> [cdp\_subnet\_prefix](#input\_cdp\_subnet\_prefix) | Prefix string to give each subnet used for CDP resources | `string` | `null` | no |
| <a name="input_cdp_subnet_range"></a> [cdp\_subnet\_range](#input\_cdp\_subnet\_range) | Size of each (internal) cluster subnet | `number` | `null` | no |
| <a name="input_cdp_subnets_default_outbound_access_enabled"></a> [cdp\_subnets\_default\_outbound\_access\_enabled](#input\_cdp\_subnets\_default\_outbound\_access\_enabled) | Enable or Disable default outbound access for the CDP subnets | `bool` | `false` | no |
| <a name="input_cdp_subnets_private_endpoint_network_policies"></a> [cdp\_subnets\_private\_endpoint\_network\_policies](#input\_cdp\_subnets\_private\_endpoint\_network\_policies) | Enable or Disable network policies for the private endpoint on the CDP subnets | `string` | `null` | no |
| <a name="input_create_delegated_subnet"></a> [create\_delegated\_subnet](#input\_create\_delegated\_subnet) | Flag to specify if the delegated subnet should be created. Only applicable if create\_vnet is true. | `bool` | `false` | no |
| <a name="input_create_nat_gateway"></a> [create\_nat\_gateway](#input\_create\_nat\_gateway) | Flag to specify if the NAT Gateway should be created. Only applicable if create\_vnet is true. | `bool` | `true` | no |
| <a name="input_create_vnet"></a> [create\_vnet](#input\_create\_vnet) | Flag to specify if the VNet should be created. Otherwise data sources will be used to lookup details of existing resources. | `bool` | `true` | no |
| <a name="input_delegated_subnet_prefix"></a> [delegated\_subnet\_prefix](#input\_delegated\_subnet\_prefix) | Prefix string to give each Delegated subnet | `string` | `null` | no |
| <a name="input_delegated_subnet_range"></a> [delegated\_subnet\_range](#input\_delegated\_subnet\_range) | Size of each Postgres Flexible Server delegated subnet | `number` | `null` | no |
| <a name="input_existing_cdp_subnet_names"></a> [existing\_cdp\_subnet\_names](#input\_existing\_cdp\_subnet\_names) | List of existing subnet names for CDP Resources. Required if create\_vnet is false. | `list(any)` | `null` | no |
| <a name="input_existing_delegated_subnet_names"></a> [existing\_delegated\_subnet\_names](#input\_existing\_delegated\_subnet\_names) | List of existing subnet names delegated for Flexible Servers. Required if create\_vnet is false. | `list(any)` | `null` | no |
| <a name="input_existing_gateway_subnet_names"></a> [existing\_gateway\_subnet\_names](#input\_existing\_gateway\_subnet\_names) | List of existing subnet names for CDP Gateway. Required if create\_vnet is false. | `list(any)` | `null` | no |
| <a name="input_existing_vnet_name"></a> [existing\_vnet\_name](#input\_existing\_vnet\_name) | Name of existing VNet. Required if create\_vnet is false. | `string` | `null` | no |
| <a name="input_gateway_subnet_prefix"></a> [gateway\_subnet\_prefix](#input\_gateway\_subnet\_prefix) | Prefix string to give each Gateway subnet | `string` | `null` | no |
| <a name="input_gateway_subnet_range"></a> [gateway\_subnet\_range](#input\_gateway\_subnet\_range) | Size of each gateway subnet | `number` | `null` | no |
| <a name="input_gateway_subnets_default_outbound_access_enabled"></a> [gateway\_subnets\_default\_outbound\_access\_enabled](#input\_gateway\_subnets\_default\_outbound\_access\_enabled) | Enable or Disable default outbound access for the Gateway subnets | `bool` | `false` | no |
| <a name="input_gateway_subnets_private_endpoint_network_policies"></a> [gateway\_subnets\_private\_endpoint\_network\_policies](#input\_gateway\_subnets\_private\_endpoint\_network\_policies) | Enable or Disable network policies for the private endpoint on the Gateway subnets | `string` | `null` | no |
| <a name="input_nat_gateway_name"></a> [nat\_gateway\_name](#input\_nat\_gateway\_name) | Name of the NAT Gateway | `string` | `null` | no |
| <a name="input_nat_public_ip_allocation_method"></a> [nat\_public\_ip\_allocation\_method](#input\_nat\_public\_ip\_allocation\_method) | Allocation method for the NAT Public IP | `string` | `"Static"` | no |
| <a name="input_nat_public_ip_name"></a> [nat\_public\_ip\_name](#input\_nat\_public\_ip\_name) | Name of the NAT Public IP | `string` | `null` | no |
| <a name="input_nat_public_ip_sku"></a> [nat\_public\_ip\_sku](#input\_nat\_public\_ip\_sku) | SKU for the NAT Public IP | `string` | `"Standard"` | no |
| <a name="input_subnet_count"></a> [subnet\_count](#input\_subnet\_count) | Number of Subnets Required | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provised resources | `map(any)` | `null` | no |
| <a name="input_vnet_cidr"></a> [vnet\_cidr](#input\_vnet\_cidr) | VNet CIDR Block | `string` | `null` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | VNet name | `string` | `null` | no |
| <a name="input_vnet_region"></a> [vnet\_region](#input\_vnet\_region) | Region which VNet will be created | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | The id of the NAT Gateway |
| <a name="output_nat_gateway_name"></a> [nat\_gateway\_name](#output\_nat\_gateway\_name) | The name of the NAT Gateway |
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | The Address Space of the VNet |
| <a name="output_vnet_cdp_subnet_ids"></a> [vnet\_cdp\_subnet\_ids](#output\_vnet\_cdp\_subnet\_ids) | List of IDs of subnets for CDP Resources |
| <a name="output_vnet_cdp_subnet_names"></a> [vnet\_cdp\_subnet\_names](#output\_vnet\_cdp\_subnet\_names) | Names of the subnets for CDP Resources |
| <a name="output_vnet_delegated_subnet_ids"></a> [vnet\_delegated\_subnet\_ids](#output\_vnet\_delegated\_subnet\_ids) | List of IDs of subnets delegated for Private Flexbile Servers |
| <a name="output_vnet_delegated_subnet_names"></a> [vnet\_delegated\_subnet\_names](#output\_vnet\_delegated\_subnet\_names) | Names of subnets delegated for Private Flexbile Servers |
| <a name="output_vnet_gateway_subnet_ids"></a> [vnet\_gateway\_subnet\_ids](#output\_vnet\_gateway\_subnet\_ids) | List of IDs of subnets for CDP Gateway |
| <a name="output_vnet_gateway_subnet_names"></a> [vnet\_gateway\_subnet\_names](#output\_vnet\_gateway\_subnet\_names) | Names of the subnets for CDP Gateway |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The ID of the VNet |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | The ID of the VNet |
<!-- END_TF_DOCS -->