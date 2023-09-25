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
| [aws_autoscaling_attachment.proxy_asg_tg_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment) | resource |
| [aws_autoscaling_group.proxy_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_template.proxy_lt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb.proxy_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.proxy_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.proxy_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_route.vpc_tgw_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_security_group.proxy_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.proxy_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.proxy_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.proxy_lb_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.proxy_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_network_interface.proxy_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/network_interface) | data source |
| [aws_route_table.proxy_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [aws_vpc.proxy_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_source_tag"></a> [agent\_source\_tag](#input\_agent\_source\_tag) | Tag to identify deployment source | `map(any)` | <pre>{<br>  "agent_source": "tf-cdp-module"<br>}</pre> | no |
| <a name="input_autoscaling_group_proxy_name"></a> [autoscaling\_group\_proxy\_name](#input\_autoscaling\_group\_proxy\_name) | Name of Autoscaling Group for the Proxy VMs. | `string` | `null` | no |
| <a name="input_autoscaling_group_scaling"></a> [autoscaling\_group\_scaling](#input\_autoscaling\_group\_scaling) | Minimum, maximum and desired size of EC2 instance in the Auto Scaling Group. | <pre>object({<br>    min_size         = number<br>    max_size         = number<br>    desired_capacity = number<br>  })</pre> | <pre>{<br>  "desired_capacity": 3,<br>  "max_size": 6,<br>  "min_size": 3<br>}</pre> | no |
| <a name="input_aws_ami"></a> [aws\_ami](#input\_aws\_ami) | The AWS AMI to use for the proxy VM | `string` | `null` | no |
| <a name="input_aws_instance_type"></a> [aws\_instance\_type](#input\_aws\_instance\_type) | The EC2 instance type to use for the proxy VM | `string` | `"t3.medium"` | no |
| <a name="input_aws_keypair_name"></a> [aws\_keypair\_name](#input\_aws\_keypair\_name) | SSH Keypair name for the proxy VM | `string` | n/a | yes |
| <a name="input_create_proxy_sg"></a> [create\_proxy\_sg](#input\_create\_proxy\_sg) | Flag to specify if the Security Group for the proxy should be created. | `bool` | `true` | no |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | List of egress rules to create. Used only if create\_proxy\_sg is true | <pre>list(object({<br>    cidrs     = list(string)<br>    from_port = number<br>    to_port   = optional(number)<br>    protocol  = string<br>  }))</pre> | <pre>[<br>  {<br>    "cidrs": [<br>      "0.0.0.0/0"<br>    ],<br>    "from_port": 0,<br>    "protocol": "all",<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_env_prefix"></a> [env\_prefix](#input\_env\_prefix) | Shorthand name for the environment. Used in resource descriptions | `string` | n/a | yes |
| <a name="input_env_tags"></a> [env\_tags](#input\_env\_tags) | Tags applied to provised resources | `map(any)` | `null` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of ingress rules to create. Used only if create\_proxy\_sg is true | <pre>list(object({<br>    cidrs     = list(string)<br>    from_port = number<br>    to_port   = optional(number)<br>    protocol  = string<br>  }))</pre> | `[]` | no |
| <a name="input_launch_template_proxy_name"></a> [launch\_template\_proxy\_name](#input\_launch\_template\_proxy\_name) | Name of Launch Template for the Proxy VMs. | `string` | `null` | no |
| <a name="input_lb_subnet_ids"></a> [lb\_subnet\_ids](#input\_lb\_subnet\_ids) | The IDs of the subnet for the Network Load Balancer | `list(any)` | n/a | yes |
| <a name="input_network_load_balancer_name"></a> [network\_load\_balancer\_name](#input\_network\_load\_balancer\_name) | Name of Network Load Balancer for the Proxy. | `string` | `null` | no |
| <a name="input_proxy_port"></a> [proxy\_port](#input\_proxy\_port) | Port number which the proxy and NLB listens | `number` | `3129` | no |
| <a name="input_proxy_public_ip"></a> [proxy\_public\_ip](#input\_proxy\_public\_ip) | Assign a public IP address to the Proxy VM | `bool` | `true` | no |
| <a name="input_proxy_security_group_id"></a> [proxy\_security\_group\_id](#input\_proxy\_security\_group\_id) | ID for existing Security Group to be used for the proxy VM. Required when create\_proxy\_sg is false | `string` | `null` | no |
| <a name="input_proxy_subnet_ids"></a> [proxy\_subnet\_ids](#input\_proxy\_subnet\_ids) | The IDs of the subnet where the proxy VMs will run | `list(any)` | n/a | yes |
| <a name="input_route_tables_to_update"></a> [route\_tables\_to\_update](#input\_route\_tables\_to\_update) | List of any route tables to update to point to the Network interface of the Proxy VM | <pre>list(object({<br>    route_tables           = list(string)<br>    destination_cidr_block = string<br>  }))</pre> | n/a | yes |
| <a name="input_security_group_proxy_name"></a> [security\_group\_proxy\_name](#input\_security\_group\_proxy\_name) | Name of Proxy Security Group for CDP environment. Used only if create\_proxy\_sg is true. | `string` | `null` | no |
| <a name="input_target_group_proxy_name"></a> [target\_group\_proxy\_name](#input\_target\_group\_proxy\_name) | Name of Target Group for the Proxy. | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for where the proxy VM will run | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_proxy_lb_arn"></a> [proxy\_lb\_arn](#output\_proxy\_lb\_arn) | ARN of the Proxy Load Balancer |
| <a name="output_proxy_lb_dns_name"></a> [proxy\_lb\_dns\_name](#output\_proxy\_lb\_dns\_name) | DNS Name of the Proxy Load Balancer |
| <a name="output_proxy_port"></a> [proxy\_port](#output\_proxy\_port) | Port where Proxy is running |
