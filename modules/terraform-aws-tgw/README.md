<!-- BEGIN_TF_DOCS -->
# Terraform Module for AWS Transit Gateway

This module contains resource files and example variable definition files for creation of AWS Transity Gateway (TGW) and attaching a specified list of VPCs via the TGW. This module also updates both the Transit Gateway and VPC route tables. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a fully private networking configuration where a CDP VPC and Networking VPC are connected using the Transit Gateway.

## Usage

The [examples](./examples) directory has example of using this module:

* `ex01-vpc-tgw-attach` demonstrates how this module can be used to create a Transit Gateway to attach a private CDP VPC with a dedicated networking VPC. The [terraform-aws-vpc](../../../terraform-aws-vpc/README.md) module is also used as part of this example.

The README and sample `terraform.tfvars.sample` describe how to use the example.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) | resource |
| [aws_ec2_transit_gateway_route.tgw_routes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route_table.tgw_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table_association.tgw_rt_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.tgw_rt_propag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.tgw_vpc_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_route.vpc_tgw_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tgw_name"></a> [tgw\_name](#input\_tgw\_name) | Name of the Transit Gateway. Also used to prefix associated TGW resource names. | `string` | n/a | yes |
| <a name="input_env_tags"></a> [env\_tags](#input\_env\_tags) | Tags applied to provisioned resources | `map(any)` | `null` | no |
| <a name="input_tgw_default_route_table_association"></a> [tgw\_default\_route\_table\_association](#input\_tgw\_default\_route\_table\_association) | Automatically associate resource attachments with the default TGW association route table. Valid values are 'enable' or 'disable' | `string` | `"disable"` | no |
| <a name="input_tgw_default_route_table_propagation"></a> [tgw\_default\_route\_table\_propagation](#input\_tgw\_default\_route\_table\_propagation) | Automatically propagate resource attachments with the default TGW propagation route table. Valid values are 'enable' or 'disable' | `string` | `"disable"` | no |
| <a name="input_tgw_dns_support"></a> [tgw\_dns\_support](#input\_tgw\_dns\_support) | Enable DNS support for the Transit Gateway. Valid values are 'enable' or 'disable' | `string` | `"enable"` | no |
| <a name="input_tgw_vpn_ecmp_support"></a> [tgw\_vpn\_ecmp\_support](#input\_tgw\_vpn\_ecmp\_support) | Enable VPN Equal Cost Multipath Protocol support for the Transit Gateway. Valid values are 'enable' or 'disable' | `string` | `"enable"` | no |
| <a name="input_vpc_attach_dns_support"></a> [vpc\_attach\_dns\_support](#input\_vpc\_attach\_dns\_support) | Default behaviour for the VPC Attachment dns\_support parameter if not specified in var.vpc\_attachments | `string` | `"enable"` | no |
| <a name="input_vpc_attach_tgw_default_route_table_association"></a> [vpc\_attach\_tgw\_default\_route\_table\_association](#input\_vpc\_attach\_tgw\_default\_route\_table\_association) | Default behaviour for the VPC Attachment transit\_gateway\_default\_route\_table\_association parameter if not specified in var.vpc\_attachments | `bool` | `false` | no |
| <a name="input_vpc_attach_tgw_default_route_table_propagation"></a> [vpc\_attach\_tgw\_default\_route\_table\_propagation](#input\_vpc\_attach\_tgw\_default\_route\_table\_propagation) | Default behaviour for the VPC Attachment transit\_gateway\_default\_route\_table\_propagation parameter if not specified in var.vpc\_attachments | `bool` | `false` | no |
| <a name="input_vpc_attachments"></a> [vpc\_attachments](#input\_vpc\_attachments) | Map of map of VPC details to attach to the Transit Gateway. Type any to avoid validation on map key but should at least contain the vpc id and subnet id for the TGW attachment. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_transit_gateway_arn"></a> [transit\_gateway\_arn](#output\_transit\_gateway\_arn) | Transit Gateway Amazon Resource Name (ARN) |
| <a name="output_transit_gateway_association_default_route_table_id"></a> [transit\_gateway\_association\_default\_route\_table\_id](#output\_transit\_gateway\_association\_default\_route\_table\_id) | ID of the default association route table |
| <a name="output_transit_gateway_id"></a> [transit\_gateway\_id](#output\_transit\_gateway\_id) | Transit Gateway identifier |
| <a name="output_transit_gateway_propagation_default_route_table_id"></a> [transit\_gateway\_propagation\_default\_route\_table\_id](#output\_transit\_gateway\_propagation\_default\_route\_table\_id) | ID of the default propagation route table |
| <a name="output_transit_gateway_route_table_details"></a> [transit\_gateway\_route\_table\_details](#output\_transit\_gateway\_route\_table\_details) | Map of Transit Gateway Route Table attributes |
| <a name="output_transit_gateway_route_table_ids"></a> [transit\_gateway\_route\_table\_ids](#output\_transit\_gateway\_route\_table\_ids) | List of Transit Gateway Route Tables |
| <a name="output_transit_gateway_vpc_attachment_details"></a> [transit\_gateway\_vpc\_attachment\_details](#output\_transit\_gateway\_vpc\_attachment\_details) | Map of Transit Gateway VPC Attachment attributes |
| <a name="output_transit_gateway_vpc_attachment_ids"></a> [transit\_gateway\_vpc\_attachment\_ids](#output\_transit\_gateway\_vpc\_attachment\_ids) | List of Transit Gateway VPC Attachment identifiers |
<!-- END_TF_DOCS -->