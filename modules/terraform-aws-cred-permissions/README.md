<!-- BEGIN_TF_DOCS -->
# Terraform Module for CDP Credential Prerequisites on AWS

This module contains resource files and example variable definition files for creation of the Cloudera Data Platform (CDP) Public Cloud Cross Account Credential pre-requisite on AWS.

Support for using a pre-existing Cross Account Role is provided via the `existing_xaccount_role_name` input variable. When this is set no policy or role resources are created. Instead a lookup of the details of the existing role takes place and the role ARN is returned.

## Usage

The [examples](./examples) directory has the following examples for Cross Account Credentials on AWS:

* `ex01-minimal-inputs` uses the minimum set of inputs for the module where the Cross Account policy and roles are to be created.

* `ex02-existing-role` passes a pre-existing Cross Account role to the module. In this case no resources are created.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>5.30 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~>5.30 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.cdp_xaccount_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cdp_xaccount_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [time_sleep.iam_propagation](https://registry.terraform.io/providers/hashicorp/time/0.9.1/docs/resources/sleep) | resource |
| [aws_iam_policy_document.cdp_xaccount_role_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.existing_xaccount_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_existing_xaccount_role_name"></a> [existing\_xaccount\_role\_name](#input\_existing\_xaccount\_role\_name) | Name of existing CDP Cross Account Role. If set then no policy or role resources are created. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provised resources | `map(any)` | `null` | no |
| <a name="input_xaccount_account_id"></a> [xaccount\_account\_id](#input\_xaccount\_account\_id) | Account ID of the cross account. Required if xaccount resources are to be created. | `string` | `null` | no |
| <a name="input_xaccount_account_policy_doc"></a> [xaccount\_account\_policy\_doc](#input\_xaccount\_account\_policy\_doc) | Contents of cross acount policy document. Required if xaccount resources are to be created. | `string` | `null` | no |
| <a name="input_xaccount_external_id"></a> [xaccount\_external\_id](#input\_xaccount\_external\_id) | External ID of the cross account. Required if xaccount resources are to be created. | `string` | `null` | no |
| <a name="input_xaccount_policy_name"></a> [xaccount\_policy\_name](#input\_xaccount\_policy\_name) | Cross Account Policy name. Required if xaccount resources are to be created. | `string` | `null` | no |
| <a name="input_xaccount_role_name"></a> [xaccount\_role\_name](#input\_xaccount\_role\_name) | Cross account Assume role Name. Required if xaccount resources are to be created. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_xaccount_role_arn"></a> [aws\_xaccount\_role\_arn](#output\_aws\_xaccount\_role\_arn) | Cross Account role ARN |
| <a name="output_aws_xaccount_role_name"></a> [aws\_xaccount\_role\_name](#output\_aws\_xaccount\_role\_name) | Cross Account role name |
<!-- END_TF_DOCS -->