<!-- BEGIN_TF_DOCS -->
# Terraform Module for AWS IAM Permissions for CML

This module contains resource files and example variable definition files for creation of the AWS IAM policies required for the Cloudera Machine Learning (CML) backup and restore functionality. This requirement is described [in this section](https://docs.cloudera.com/machine-learning/cloud/workspaces/topics/ml-backup-restore-prerequisites.html) of the CML documentation.

## Usage

The [examples](./examples) directory has an example AWS IAM policy creation on AWS:

* `ex01-minimal-inputs` uses the minimum set of inputs for the module.

An example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_assert"></a> [assert](#requirement\_assert) | >= 0.15.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>5.30 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~>5.30 |
| <a name="provider_http"></a> [http](#provider\_http) | >= 3.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cml_backup_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cml_restore_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.cdp_xaccount_role_cml_backup_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cdp_xaccount_role_cml_restore_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role.xaccount_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [http_http.cml_backup_policy_doc](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.cml_restore_policy_doc](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cml_backup_policy_name"></a> [cml\_backup\_policy\_name](#input\_cml\_backup\_policy\_name) | CDP CML Backup Policy name | `string` | n/a | yes |
| <a name="input_cml_restore_policy_name"></a> [cml\_restore\_policy\_name](#input\_cml\_restore\_policy\_name) | CDP CML Restore Policy name | `string` | n/a | yes |
| <a name="input_xaccount_role_name"></a> [xaccount\_role\_name](#input\_xaccount\_role\_name) | Name of existing cross account Assume role Name. | `string` | n/a | yes |
| <a name="input_cml_backup_policy_doc"></a> [cml\_backup\_policy\_doc](#input\_cml\_backup\_policy\_doc) | Contents of CDP CML Backup Policy Document. If not specified document is downloaded from Cloudera Document repository | `string` | `null` | no |
| <a name="input_cml_restore_policy_doc"></a> [cml\_restore\_policy\_doc](#input\_cml\_restore\_policy\_doc) | Contents of CDP CML Restore Policy Document. If not specified document is downloaded from Cloudera Document repository | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to provised resources | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_cml_backup_policy_arn"></a> [aws\_cml\_backup\_policy\_arn](#output\_aws\_cml\_backup\_policy\_arn) | CML Backup IAM Policy ARN |
| <a name="output_aws_cml_restore_policy_arn"></a> [aws\_cml\_restore\_policy\_arn](#output\_aws\_cml\_restore\_policy\_arn) | CML Restore IAM Policy ARN |
<!-- END_TF_DOCS -->