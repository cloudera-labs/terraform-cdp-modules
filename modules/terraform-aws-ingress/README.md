<!-- BEGIN_TF_DOCS -->
# Terraform Module for AWS Ingress (Security Groups)

This module contains resource files and example variable definition files for creating and managing the Default and Knox AWS security groups for Cloudera on cloud deployments.

Support for using a pre-existing Security Groups is provided via the `existing_default_security_group_name` and `existing_knox_security_group_name` input variables. When this is set no security group resources are created. Instead a lookup of the details of the existing security group takes place and the ID is returned.

## Usage

The [examples](./examples) directory has example of using this module:

* `ex01-minimal_inputs` demonstrates how this module can be used to create security groups with minimum required inputs. The [terraform-aws-vpc](../../../terraform-aws-vpc/README.md) module is also used as part of this example.
* `ex02-existing_sgs` demonstrates how to use existing security groups with this module.

The README and sample `terraform.tfvars.sample` describe how to use the example.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 1.3.0 |
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
| [aws_ec2_managed_prefix_list.cdp_prefix_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list) | resource |
| [aws_ec2_managed_prefix_list_entry.cdp_prefix_list_entry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_managed_prefix_list_entry) | resource |
| [aws_security_group.cdp_default_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.cdp_knox_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.cdp_default_sg_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.cdp_knox_sg_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.cdp_default_extra_sg_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.cdp_default_extra_sg_ingress_pl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.cdp_default_sg_ingress_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.cdp_default_vpc_sg_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.cdp_knox_extra_sg_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.cdp_knox_extra_sg_ingress_pl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.cdp_knox_sg_ingress_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.cdp_knox_vpc_sg_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_security_group.cdp_default_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_security_group.cdp_knox_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for where the security groups will be created. | `string` | n/a | yes |
| <a name="input_cdp_default_sg_egress_cidrs"></a> [cdp\_default\_sg\_egress\_cidrs](#input\_cdp\_default\_sg\_egress\_cidrs) | List of egress CIDR blocks for CDP Default Security Group Egress rule | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_cdp_knox_sg_egress_cidrs"></a> [cdp\_knox\_sg\_egress\_cidrs](#input\_cdp\_knox\_sg\_egress\_cidrs) | List of egress CIDR blocks for CDP Knox Security Group Egress rule | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_default_security_group_name"></a> [default\_security\_group\_name](#input\_default\_security\_group\_name) | Default Security Group for Cloudera on cloud environment | `string` | `null` | no |
| <a name="input_existing_default_security_group_name"></a> [existing\_default\_security\_group\_name](#input\_existing\_default\_security\_group\_name) | Name of existing Default Security Group for Cloudera on cloud environment. If set then no security group or ingress rules are created for the Default SG. | `string` | `null` | no |
| <a name="input_existing_knox_security_group_name"></a> [existing\_knox\_security\_group\_name](#input\_existing\_knox\_security\_group\_name) | Name of existing Knox Security Group for Cloudera on cloud environment. If set then no security group or ingress rules are created for the Knox SG. | `string` | `null` | no |
| <a name="input_ingress_extra_cidrs_and_ports"></a> [ingress\_extra\_cidrs\_and\_ports](#input\_ingress\_extra\_cidrs\_and\_ports) | List of extra CIDR blocks and ports to include in Security Group Ingress rules | <pre>object({<br/>    cidrs = list(string)<br/>    ports = list(number)<br/>  })</pre> | <pre>{<br/>  "cidrs": [],<br/>  "ports": []<br/>}</pre> | no |
| <a name="input_ingress_vpc_cidr"></a> [ingress\_vpc\_cidr](#input\_ingress\_vpc\_cidr) | VPC CIDR block to include in Security Group Ingress rule | `string` | `null` | no |
| <a name="input_knox_security_group_name"></a> [knox\_security\_group\_name](#input\_knox\_security\_group\_name) | Knox Security Group for Cloudera on cloud environment | `string` | `null` | no |
| <a name="input_prefix_list_name"></a> [prefix\_list\_name](#input\_prefix\_list\_name) | Name of the AWS Prefix List to use for the security group rules. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provisioned resources | `map(any)` | `null` | no |
| <a name="input_use_prefix_list_for_ingress"></a> [use\_prefix\_list\_for\_ingress](#input\_use\_prefix\_list\_for\_ingress) | Whether to use prefix lists for ingress rules instead of direct CIDR blocks | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_prefix_list_id"></a> [aws\_prefix\_list\_id](#output\_aws\_prefix\_list\_id) | AWS managed prefix list ID |
| <a name="output_aws_security_group_default_arn"></a> [aws\_security\_group\_default\_arn](#output\_aws\_security\_group\_default\_arn) | AWS security group ARN for default CDP SG |
| <a name="output_aws_security_group_default_id"></a> [aws\_security\_group\_default\_id](#output\_aws\_security\_group\_default\_id) | AWS security group id for default CDP SG |
| <a name="output_aws_security_group_knox_arn"></a> [aws\_security\_group\_knox\_arn](#output\_aws\_security\_group\_knox\_arn) | AWS security group ARN for Knox CDP SG |
| <a name="output_aws_security_group_knox_id"></a> [aws\_security\_group\_knox\_id](#output\_aws\_security\_group\_knox\_id) | AWS security group id for Knox CDP SG |
<!-- END_TF_DOCS -->