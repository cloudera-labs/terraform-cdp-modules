<!-- BEGIN_TF_DOCS -->
# Terraform Module for AWS VPC suitable for hosting AWS Network Firewall

This module contains resource files and example variable definition files for creation of the Virtual Private Cloud (VPC) suitable for running a Firewall in a distributed architecture on AWS. It creates subnets across multiple availability zones for NAT gateways, the Network Firewall and for a Transit Gateway connections to other VPCs.

The module can be used for creation of the a networking VPC which runs the AWS Network Firewall and connects to a Cloudera on cloud full-private deployment.

## Usage

The [examples](./examples) directory has example creating a VPC:

* `ex01-fw-vpc` uses the minimum set of inputs to create a AWS VPC suitable for hosting the AWS Network Firewall.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.30 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.30 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_default_route_table.default_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_eip.nat_gateway_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.fw_nat_rtb_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.nat_igw_rtb_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.fw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.fw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.fw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.zones_in_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nat_gateway_name_prefix"></a> [nat\_gateway\_name\_prefix](#input\_nat\_gateway\_name\_prefix) | Prefix string for the name of all NAT Gateway resources | `string` | n/a | yes |
| <a name="input_route_table_name_prefix"></a> [route\_table\_name\_prefix](#input\_route\_table\_name\_prefix) | Prefix string for the name of all Route Tables created | `string` | n/a | yes |
| <a name="input_subnet_name_prefix"></a> [subnet\_name\_prefix](#input\_subnet\_name\_prefix) | Prefix string for the name of all Subnets created | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR Block. Only used when create\_vpc is true. | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | n/a | yes |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Enable DNS Hostname support for the VPC. Only used when create\_vpc is true. | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable DNS support for the VPC. Only used when create\_vpc is true. | `bool` | `true` | no |
| <a name="input_fw_cidr_range"></a> [fw\_cidr\_range](#input\_fw\_cidr\_range) | Size of each Firewall subnets. | `number` | `24` | no |
| <a name="input_nat_cidr_range"></a> [nat\_cidr\_range](#input\_nat\_cidr\_range) | Size of each NAT subnets. | `number` | `24` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to VPC resources. | `map(any)` | `null` | no |
| <a name="input_tgw_cidr_range"></a> [tgw\_cidr\_range](#input\_tgw\_cidr\_range) | Size of each Transit Gateway subnets. | `number` | `24` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_route_table"></a> [default\_route\_table](#output\_default\_route\_table) | The ID of the default route table |
| <a name="output_fw_subnet_ids"></a> [fw\_subnet\_ids](#output\_fw\_subnet\_ids) | The IDs of Firewall subnets |
| <a name="output_fw_subnet_route_tables"></a> [fw\_subnet\_route\_tables](#output\_fw\_subnet\_route\_tables) | List of IDs of the routes tables associated with the Firewall subnets |
| <a name="output_fw_subnets"></a> [fw\_subnets](#output\_fw\_subnets) | All details of the Firewall subnets |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | The ID of the Internet Gateway |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | List of IDs of the NAT Gateways |
| <a name="output_nat_subnet_ids"></a> [nat\_subnet\_ids](#output\_nat\_subnet\_ids) | The IDs of NAT subnets |
| <a name="output_nat_subnet_route_tables"></a> [nat\_subnet\_route\_tables](#output\_nat\_subnet\_route\_tables) | List of IDs of the routes tables associated with the NAT subnets |
| <a name="output_nat_subnets"></a> [nat\_subnets](#output\_nat\_subnets) | All details of the NAT subnets |
| <a name="output_tgw_subnet_ids"></a> [tgw\_subnet\_ids](#output\_tgw\_subnet\_ids) | The IDs of Transit Gateway subnets |
| <a name="output_tgw_subnet_route_tables"></a> [tgw\_subnet\_route\_tables](#output\_tgw\_subnet\_route\_tables) | List of IDs of the routes tables associated with the Transit Gateway subnets |
| <a name="output_tgw_subnets"></a> [tgw\_subnets](#output\_tgw\_subnets) | All details of the Transit Gateway subnets |
| <a name="output_vpc_cidr_blocks"></a> [vpc\_cidr\_blocks](#output\_vpc\_cidr\_blocks) | CIDR Block Associations for the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->