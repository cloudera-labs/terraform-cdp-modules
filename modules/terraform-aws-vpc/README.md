<!-- BEGIN_TF_DOCS -->
# Terraform Module for AWS VPC

This module contains resource files and example variable definition files for creation of the Virtual Private Cloud (VPC) on AWS. The module can be used for creation of the pre-requisite resources for Cloudera Data Platform (CDP) Public Cloud. It is also possible to use this module to create a more generic VPC - this can be used for as a networking VPC in a private CDP environment.

## Usage

The [examples](./examples) directory has example AWS VPCs for different scenarios:

* `ex01-cdp-vpc` uses the minimum set of inputs to create a AWS VPC suitable for CDP Public Cloud.

* `ex02-network-vpc` created a generic network VPC.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.19.0 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.zones_in_region](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/availability_zones) | data source |
| [aws_subnets.vpc_subnets](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/4.67.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_cidr_range"></a> [private\_cidr\_range](#input\_private\_cidr\_range) | Size of each private subnet. Only used when create\_vpc is true. | `number` | n/a | yes |
| <a name="input_public_cidr_range"></a> [public\_cidr\_range](#input\_public\_cidr\_range) | Size of each public subnet. Only used when create\_vpc is true. | `number` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR Block. Only used when create\_vpc is true. | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC. Only used when create\_vpc is true. | `string` | n/a | yes |
| <a name="input_cdp_vpc"></a> [cdp\_vpc](#input\_cdp\_vpc) | Flag to indicate if the VPC is for a CDP environment. Only used when create\_vpc is true. | `bool` | `true` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Flag to specify if the VPC should be created. Otherwise data sources will be used to lookup details of existing resources. | `bool` | `true` | no |
| <a name="input_deployment_template"></a> [deployment\_template](#input\_deployment\_template) | Deployment Pattern to use for Cloud resources and CDP | `string` | `null` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Enable DNS Hostname support for the VPC. Only used when create\_vpc is true. | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable DNS support for the VPC. Only used when create\_vpc is true. | `bool` | `true` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Enable NAT Gateway for VPC. Only used when create\_vpc is true. | `bool` | `null` | no |
| <a name="input_existing_private_subnet_ids"></a> [existing\_private\_subnet\_ids](#input\_existing\_private\_subnet\_ids) | List of existing private subnet ids. Required if create\_vpc is false. | `list(any)` | `null` | no |
| <a name="input_existing_public_subnet_ids"></a> [existing\_public\_subnet\_ids](#input\_existing\_public\_subnet\_ids) | List of existing public subnet ids. Required if create\_vpc is false. | `list(any)` | `null` | no |
| <a name="input_existing_vpc_id"></a> [existing\_vpc\_id](#input\_existing\_vpc\_id) | ID of existing VPC. Required if create\_vpc is false. | `string` | `null` | no |
| <a name="input_private_network_extensions"></a> [private\_network\_extensions](#input\_private\_network\_extensions) | Enable creation of resources for connectivity to CDP Control Plane (public subnet and NAT Gateway) for Private Deployment. Only relevant for private deployment template. Only used when create\_vpc is true. | `bool` | `null` | no |
| <a name="input_private_subnet_tags"></a> [private\_subnet\_tags](#input\_private\_subnet\_tags) | Extra tags to apply to Private Subnets. Only used when create\_vpc is true. | `map(any)` | `null` | no |
| <a name="input_public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | Extra tags to apply to Private Subnets. Only used when create\_vpc is true. | `map(any)` | `null` | no |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Use a single NAT Gateway for the VPC. Only used when create\_vpc is true. | `bool` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to VPC resources. Only used when create\_vpc is true. | `map(any)` | `null` | no |
| <a name="input_vpc_private_inbound_acl_rules"></a> [vpc\_private\_inbound\_acl\_rules](#input\_vpc\_private\_inbound\_acl\_rules) | Private subnets inbound network ACLs. Exposes default value of VPC module variable to allow for overriding. Only used when create\_vpc is true. | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_vpc_private_outbound_acl_rules"></a> [vpc\_private\_outbound\_acl\_rules](#input\_vpc\_private\_outbound\_acl\_rules) | Private subnets outbound network ACLs. Exposes default value of VPC module variable to allow for overriding. Only used when create\_vpc is true. | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_vpc_public_inbound_acl_rules"></a> [vpc\_public\_inbound\_acl\_rules](#input\_vpc\_public\_inbound\_acl\_rules) | Inbound network ACLs for Public subnets. Exposes default value of VPC module variable to allow for overriding. Only used when create\_vpc is true. | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_vpc_public_outbound_acl_rules"></a> [vpc\_public\_outbound\_acl\_rules](#input\_vpc\_public\_outbound\_acl\_rules) | Public subnets outbound network ACLs. Exposes default value of VPC module variable to allow for overriding. Only used when create\_vpc is true. | `list(map(string))` | <pre>[<br>  {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_vpc_public_subnets_map_public_ip_on_launch"></a> [vpc\_public\_subnets\_map\_public\_ip\_on\_launch](#input\_vpc\_public\_subnets\_map\_public\_ip\_on\_launch) | Auto-assign public IP on launch for instances created in Public Subnets.  Exposes default value of VPC module variable to allow for overriding. Only used when create\_vpc is true. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_route_table"></a> [default\_route\_table](#output\_default\_route\_table) | The ID of the default route table |
| <a name="output_private_route_tables"></a> [private\_route\_tables](#output\_private\_route\_tables) | List of IDs of the private route tables |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of IDs of private subnets |
| <a name="output_public_route_tables"></a> [public\_route\_tables](#output\_public\_route\_tables) | List of IDs of the public route tables |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of IDs of public subnets |
| <a name="output_vpc_cidr_blocks"></a> [vpc\_cidr\_blocks](#output\_vpc\_cidr\_blocks) | CIDR Block Associations for the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vpc_subnets"></a> [vpc\_subnets](#output\_vpc\_subnets) | Full list of subnets associated with the VPC |
<!-- END_TF_DOCS -->