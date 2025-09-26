<!-- BEGIN_TF_DOCS -->
# Terraform Module for Azure Ingress (Security Groups)

This module contains resource files and example variable definition files for creating and managing the Default and Knox Azure network security groups for Cloudera on cloud deployments.

Support for using a pre-existing Security Groups is provided via the `existing_default_security_group_name` and `existing_knox_security_group_name` input variables. When this is set no security group resources are created. Instead a lookup of the details of the existing security group takes place and the ID is returned.

## Usage

The [examples](./examples) directory has example Azure Cloud Service Provider deployments for different scenarios:

* `ex01-minimal_inputs` demonstrates how this module can be used to create security groups with minimum required inputs.
* `ex02-existing_sgs` demonstrates how to use existing security groups with this module.

The README and sample `terraform.tfvars.sample` describe how to use the example.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
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
| [azurerm_network_security_group.cdp_default_sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.cdp_knox_sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.cdp_default_sg_ingress_extra_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.cdp_knox_sg_ingress_extra_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_group.cdp_default_sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/network_security_group) | data source |
| [azurerm_network_security_group.cdp_knox_sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/network_security_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_region"></a> [azure\_region](#input\_azure\_region) | Region which Cloud resources will be created | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Azrue Resource Group for Managed Identities. | `string` | n/a | yes |
| <a name="input_default_security_group_ingress_destination_address_prefix"></a> [default\_security\_group\_ingress\_destination\_address\_prefix](#input\_default\_security\_group\_ingress\_destination\_address\_prefix) | Destination address prefix for Default Security Group Ingress rules | `string` | `"*"` | no |
| <a name="input_default_security_group_ingress_priority"></a> [default\_security\_group\_ingress\_priority](#input\_default\_security\_group\_ingress\_priority) | Priority for Default Security Group Ingress rules | `number` | `201` | no |
| <a name="input_default_security_group_ingress_protocol"></a> [default\_security\_group\_ingress\_protocol](#input\_default\_security\_group\_ingress\_protocol) | Protocol for Default Security Group Ingress rules | `string` | `"Tcp"` | no |
| <a name="input_default_security_group_name"></a> [default\_security\_group\_name](#input\_default\_security\_group\_name) | Default Security Group for Cloudera on cloud environment | `string` | `null` | no |
| <a name="input_existing_default_security_group_name"></a> [existing\_default\_security\_group\_name](#input\_existing\_default\_security\_group\_name) | Name of existing Default Security Group for Cloudera on cloud environment. If set then no security group or ingress rules are created for the Default SG. | `string` | `null` | no |
| <a name="input_existing_knox_security_group_name"></a> [existing\_knox\_security\_group\_name](#input\_existing\_knox\_security\_group\_name) | Name of existing Knox Security Group for Cloudera on cloud environment. If set then no security group or ingress rules are created for the Knox SG. | `string` | `null` | no |
| <a name="input_ingress_extra_cidrs_and_ports"></a> [ingress\_extra\_cidrs\_and\_ports](#input\_ingress\_extra\_cidrs\_and\_ports) | List of extra CIDR blocks and ports to include in Security Group Ingress rules | <pre>object({<br/>    cidrs = list(string)<br/>    ports = list(number)<br/>  })</pre> | <pre>{<br/>  "cidrs": [],<br/>  "ports": []<br/>}</pre> | no |
| <a name="input_knox_security_group_ingress_destination_address_prefix"></a> [knox\_security\_group\_ingress\_destination\_address\_prefix](#input\_knox\_security\_group\_ingress\_destination\_address\_prefix) | Destination address prefix for Knox Security Group Ingress rules | `string` | `"*"` | no |
| <a name="input_knox_security_group_ingress_priority"></a> [knox\_security\_group\_ingress\_priority](#input\_knox\_security\_group\_ingress\_priority) | Priority for Knox Security Group Ingress rules | `number` | `201` | no |
| <a name="input_knox_security_group_ingress_protocol"></a> [knox\_security\_group\_ingress\_protocol](#input\_knox\_security\_group\_ingress\_protocol) | Protocol for Knox Security Group Ingress rules | `string` | `"Tcp"` | no |
| <a name="input_knox_security_group_name"></a> [knox\_security\_group\_name](#input\_knox\_security\_group\_name) | Knox Security Group for CCloudera on cloud environment | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provised resources | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_default_security_group_uri"></a> [azure\_default\_security\_group\_uri](#output\_azure\_default\_security\_group\_uri) | Azure Default Security Group URI |
| <a name="output_azure_knox_security_group_uri"></a> [azure\_knox\_security\_group\_uri](#output\_azure\_knox\_security\_group\_uri) | Azure Knox Security Group URI |
<!-- END_TF_DOCS -->