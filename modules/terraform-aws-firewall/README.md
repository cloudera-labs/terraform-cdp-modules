<!-- BEGIN_TF_DOCS -->
# Terraform Module for AWS Network Firewall

This module contains resource files and example variable definition files to create and configure an AWS Network Firewall. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a fully private networking configuration where the CDP Environment is connected to a Networking VPC running the Firewall.

## Usage

The [examples](./examples) directory has example of using this module:

* `ex01-minimal_inputs` demonstrates how this module can be used to within a networking VPC. The [terraform-aws-nfw-vpc](../../../terraform-aws-nfw-vpc/README.md) module is also used as part of this example.

The sample `terraform.tfvars.sample` describes the required inputs for the example.

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
| [aws_cloudwatch_log_group.nfw_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_networkfirewall_firewall.fw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall) | resource |
| [aws_networkfirewall_firewall_policy.fw_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall_policy) | resource |
| [aws_networkfirewall_logging_configuration.nfw_log_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_logging_configuration) | resource |
| [aws_networkfirewall_rule_group.cdp_env_fw_rg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_rule_group) | resource |
| [aws_route.vpc_tgw_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc.cdp_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpc.network_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cdp_firewall_rule_group_name"></a> [cdp\_firewall\_rule\_group\_name](#input\_cdp\_firewall\_rule\_group\_name) | Name of the CDP Rule Group. | `string` | n/a | yes |
| <a name="input_cdp_vpc_id"></a> [cdp\_vpc\_id](#input\_cdp\_vpc\_id) | VPC ID for where the CDP environment is running | `string` | n/a | yes |
| <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name) | Name of the Firewall. | `string` | n/a | yes |
| <a name="input_firewall_policy_name"></a> [firewall\_policy\_name](#input\_firewall\_policy\_name) | Name of the Firewall Policy. | `string` | n/a | yes |
| <a name="input_firewall_subnet_ids"></a> [firewall\_subnet\_ids](#input\_firewall\_subnet\_ids) | List of subnet ids to assign to the Firewall. | `list(string)` | n/a | yes |
| <a name="input_network_vpc_id"></a> [network\_vpc\_id](#input\_network\_vpc\_id) | VPC ID for where the Networking components are running | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region, used in Domain allowlist configuration files. If not provided will perform lookup of aws\_region data source. | `string` | `null` | no |
| <a name="input_cdp_firewall_domain_allowlist"></a> [cdp\_firewall\_domain\_allowlist](#input\_cdp\_firewall\_domain\_allowlist) | Domain allowlist for CDP Rule Group. | `list(string)` | <pre>[<br>  "cloudera.com"<br>]</pre> | no |
| <a name="input_cdp_fw_rule_group_capacity"></a> [cdp\_fw\_rule\_group\_capacity](#input\_cdp\_fw\_rule\_group\_capacity) | Capacity (maximum number of operating resources) for the CDP Firewall Rule Group | `number` | `300` | no |
| <a name="input_cdp_region"></a> [cdp\_region](#input\_cdp\_region) | CDP Control Plane region, used in Proxy Whitelist configuration files. | `string` | `"us-west-1"` | no |
| <a name="input_firewall_logging_config"></a> [firewall\_logging\_config](#input\_firewall\_logging\_config) | Logging config for cloudwatch logs created for network Firewall | `map(any)` | <pre>{<br>  "alert": {<br>    "retention_in_days": 3<br>  },<br>  "flow": {<br>    "retention_in_days": 1<br>  }<br>}</pre> | no |
| <a name="input_route_tables_to_update"></a> [route\_tables\_to\_update](#input\_route\_tables\_to\_update) | List of any route tables to update to target the Firewall Endpoint | <pre>list(object({<br>    route_tables           = list(string)<br>    availability_zones     = optional(list(string))<br>    destination_cidr_block = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provisioned resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nfw_arn"></a> [nfw\_arn](#output\_nfw\_arn) | The Amazon Resource Name (ARN) of the AWS Network Firewall |
| <a name="output_nfw_id"></a> [nfw\_id](#output\_nfw\_id) | The Amazon Resource id of the AWS Network Firewall |
| <a name="output_nfw_logging_configuration_ids"></a> [nfw\_logging\_configuration\_ids](#output\_nfw\_logging\_configuration\_ids) | The Amazon Resource id (ARN) of the logging configuration associated with the AWS Network Firewall |
| <a name="output_nfw_policy_arn"></a> [nfw\_policy\_arn](#output\_nfw\_policy\_arn) | The Amazon Resource Name (ARN) that identifies the firewall policy |
| <a name="output_nfw_policy_id"></a> [nfw\_policy\_id](#output\_nfw\_policy\_id) | The Amazon Resource id of the firewall policy for the AWS Network Firewall |
<!-- END_TF_DOCS -->