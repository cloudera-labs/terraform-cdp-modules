<!-- BEGIN_TF_DOCS -->
# Terraform Module for AWS Bastion

This module contains resource files and example variable definition files to create a Bastion EC2 instance on AWS. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a secure environment, where the CDP Environment requires a Bastion host.

## Usage

The [examples](./examples) directory has example of using this module:

* `ex01-minimal_inputs` demonstrates how this module can be used to create a Bastion instance in a networking VPC. The [terraform-aws-vpc](../../../terraform-aws-vpc/README.md) module is also used as part of this example.

The sample `terraform.tfvars.sample` describes the required inputs for the example.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
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
| [aws_eip.bastion_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.bastion_eip_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_instance.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.bastion_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.bastion_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.bastion_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.bastion_default_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_aws_keypair_name"></a> [bastion\_aws\_keypair\_name](#input\_bastion\_aws\_keypair\_name) | SSH Keypair name for the bastion VM. | `string` | n/a | yes |
| <a name="input_bastion_subnet_id"></a> [bastion\_subnet\_id](#input\_bastion\_subnet\_id) | The ID of the subnet where the bastion VM will run. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for where the bastion VM will run. | `string` | n/a | yes |
| <a name="input_bastion_aws_ami"></a> [bastion\_aws\_ami](#input\_bastion\_aws\_ami) | The AWS AMI to use for the bastion VM. | `string` | `null` | no |
| <a name="input_bastion_aws_instance_type"></a> [bastion\_aws\_instance\_type](#input\_bastion\_aws\_instance\_type) | The EC2 instance type to use for the bastion VM. | `string` | `"t3.medium"` | no |
| <a name="input_bastion_aws_root_volume"></a> [bastion\_aws\_root\_volume](#input\_bastion\_aws\_root\_volume) | Root volume details for the bastion instance. | <pre>object({<br/>    delete_on_termination = optional(bool, true)<br/>    volume_size           = optional(number, 100)<br/>    volume_type           = optional(string)<br/>  })</pre> | `{}` | no |
| <a name="input_bastion_az"></a> [bastion\_az](#input\_bastion\_az) | The availability zone where the bastion instance will be created. | `string` | `null` | no |
| <a name="input_bastion_cpu_options"></a> [bastion\_cpu\_options](#input\_bastion\_cpu\_options) | The CPU options for the bastion instance (e.g., number of cores and threads per core) | <pre>object({<br/>    core_count       = number<br/>    threads_per_core = number<br/>  })</pre> | `null` | no |
| <a name="input_bastion_get_password_data"></a> [bastion\_get\_password\_data](#input\_bastion\_get\_password\_data) | Return the password data for the bastion instance | `bool` | `null` | no |
| <a name="input_bastion_host_name"></a> [bastion\_host\_name](#input\_bastion\_host\_name) | Name of bastion host. | `string` | `null` | no |
| <a name="input_bastion_inst_profile"></a> [bastion\_inst\_profile](#input\_bastion\_inst\_profile) | The IAM instance profile for the bastion instance. | `string` | `null` | no |
| <a name="input_bastion_monitoring"></a> [bastion\_monitoring](#input\_bastion\_monitoring) | Whether to enable detailed monitoring for the bastion instance | `bool` | `null` | no |
| <a name="input_bastion_placement_grp"></a> [bastion\_placement\_grp](#input\_bastion\_placement\_grp) | The placement group to associate with the bastion instance | `string` | `null` | no |
| <a name="input_bastion_private_ip"></a> [bastion\_private\_ip](#input\_bastion\_private\_ip) | The private IP address for the bastion instance | `string` | `null` | no |
| <a name="input_bastion_security_group_id"></a> [bastion\_security\_group\_id](#input\_bastion\_security\_group\_id) | ID for existing Security Group to be used for the bastion VM. Required when create\_bastion\_sg is false. | `string` | `null` | no |
| <a name="input_bastion_security_group_name"></a> [bastion\_security\_group\_name](#input\_bastion\_security\_group\_name) | Name of bastion Security Group for CDP environment. Used only if create\_bastion\_sg is true. | `string` | `null` | no |
| <a name="input_bastion_shutdown_behaviour"></a> [bastion\_shutdown\_behaviour](#input\_bastion\_shutdown\_behaviour) | The instance initiated shutdown behavior (e.g., stop or terminate) | `string` | `null` | no |
| <a name="input_bastion_src_dest_check"></a> [bastion\_src\_dest\_check](#input\_bastion\_src\_dest\_check) | Whether to disable source/destination checks for the bastion instance | `bool` | `null` | no |
| <a name="input_bastion_tenancy"></a> [bastion\_tenancy](#input\_bastion\_tenancy) | The tenancy option for the bastion instance (e.g., default or dedicated) | `string` | `null` | no |
| <a name="input_bastion_user_data"></a> [bastion\_user\_data](#input\_bastion\_user\_data) | Base64-encoded user data for the bastion instance. | `string` | `null` | no |
| <a name="input_create_bastion_sg"></a> [create\_bastion\_sg](#input\_create\_bastion\_sg) | Flag to specify if the Security Group for the bastion should be created. | `bool` | `true` | no |
| <a name="input_create_eip"></a> [create\_eip](#input\_create\_eip) | Flag to specify if an Elastic IP for the bastion should be created and assigned. | `bool` | `false` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | Whether to disable API termination for the bastion instance | `bool` | `null` | no |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | List of egress rules to create. Used only if create\_bastion\_sg is true. | <pre>list(object({<br/>    cidrs     = list(string)<br/>    from_port = number<br/>    to_port   = optional(number)<br/>    protocol  = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "cidrs": [<br/>      "0.0.0.0/0"<br/>    ],<br/>    "from_port": 0,<br/>    "protocol": "all",<br/>    "to_port": 0<br/>  }<br/>]</pre> | no |
| <a name="input_eip_name"></a> [eip\_name](#input\_eip\_name) | Name of Elastic IP. | `string` | `null` | no |
| <a name="input_enable_bastion_public_ip"></a> [enable\_bastion\_public\_ip](#input\_enable\_bastion\_public\_ip) | Whether to create and assign an public IP to the bastion host. | `bool` | `null` | no |
| <a name="input_env_tags"></a> [env\_tags](#input\_env\_tags) | Tags applied to provisioned resources. | `map(any)` | `{}` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of ingress rules to create. Used only if create\_bastion\_sg is true. | <pre>list(object({<br/>    cidrs     = list(string)<br/>    from_port = number<br/>    to_port   = optional(number)<br/>    protocol  = string<br/>  }))</pre> | `[]` | no |
| <a name="input_replace_on_user_data_change"></a> [replace\_on\_user\_data\_change](#input\_replace\_on\_user\_data\_change) | Trigger a destroy and recreate the EC2 instance when user\_data changes. Defaults to false if not set. | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_instance_details"></a> [bastion\_instance\_details](#output\_bastion\_instance\_details) | The details of the Bastion instance. |
| <a name="output_bastion_instance_id"></a> [bastion\_instance\_id](#output\_bastion\_instance\_id) | The ID of the Bastion instance. |
| <a name="output_bastion_instance_private_ip"></a> [bastion\_instance\_private\_ip](#output\_bastion\_instance\_private\_ip) | The private IP address of the Bastion instance. |
| <a name="output_bastion_instance_public_ip"></a> [bastion\_instance\_public\_ip](#output\_bastion\_instance\_public\_ip) | The public IP address of the Bastion instance. |
| <a name="output_bastion_password_data"></a> [bastion\_password\_data](#output\_bastion\_password\_data) | The password data for the Bastion instance. |
<!-- END_TF_DOCS -->