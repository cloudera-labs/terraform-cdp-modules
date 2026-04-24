<!-- BEGIN_TF_DOCS -->
# Example 05: Cloudera on AWS Hybrid Environment

This example demonstrates how to deploy a Cloudera Hybrid environment on AWS. Cloudera Hybrid Environments provide the ability to federate access to data and run workloads across both on-premises and cloud environments.

For more information, see the [Cloudera Hybrid Cloud Overview](https://docs.cloudera.com/hybrid-cloud/latest/overview/topics/hc-overview.html).

## Usage

### 1. Clone the Repository

```bash
git clone https://github.com/cloudera-labs/terraform-cdp-modules.git
cd terraform-cdp-modules/modules/terraform-cdp-deploy/examples/ex05-aws-hybrid
```

### 2. Configure Variables

Copy the sample variables file and customize it:

```bash
cp terraform.tfvars.sample terraform.tfvars
```

Edit `terraform.tfvars` and provide values for the required variables:

```hcl
env_prefix = "myenv"                    # Environment name prefix (max 12 chars)
aws_region = "us-west-2"                # Target AWS region
aws_key_pair = "my-keypair"             # Existing EC2 key pair name
deployment_template = "semi-private"    # Options: public, semi-private, or private

# Network ingress settings
ingress_extra_cidrs_and_ports = {
  cidrs = ["203.0.113.0/32"]
  ports = [443, 22]
}
```

### 3. Set AWS and Cloudera Credentials

Configure your **Cloudera API credentials**, by following the steps for [Generating an API access key](https://docs.cloudera.com/cdp-public-cloud/cloud/cli/topics/mc-cli-generating-an-api-access-key.html).

Set you **AWS access credentials** to create the Cloud resources via the Terraform aws provider. See the [AWS documentation for Managing access keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html).

### 5. Initialize Terraform

```bash
terraform init
```

### 6. Plan the Deployment

```bash
terraform plan
```

Review the planned changes to ensure they match your expectations.

### 7. Apply the Configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment. The deployment process may take 45-60 minutes to complete.

### 8. Verify the Deployment

Once complete, you can verify the deployment by:

- Logging into the CDP Management Console

## Resource Cleanup

To destroy all created resources:

```bash
terraform destroy
```

**Warning**: This will delete the CDP environment, and all associated AWS resources including S3 buckets and their contents.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>5.30 |
| <a name="requirement_cdp"></a> [cdp](#requirement\_cdp) | >= 0.6.1 |
| <a name="requirement_http"></a> [http](#requirement\_http) | ~> 3.2.1 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.5.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cdp"></a> [cdp](#provider\_cdp) | 0.10.10 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cdp_aws_prereqs"></a> [cdp\_aws\_prereqs](#module\_cdp\_aws\_prereqs) | ../../../terraform-cdp-aws-pre-reqs | n/a |
| <a name="module_cdp_deploy"></a> [cdp\_deploy](#module\_cdp\_deploy) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [cdp_environments_aws_credential_prerequisites.cdp_prereqs](https://registry.terraform.io/providers/cloudera/cdp/latest/docs/data-sources/environments_aws_credential_prerequisites) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_key_pair"></a> [aws\_key\_pair](#input\_aws\_key\_pair) | Name of the Public SSH key for the CDP environment | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region which Cloud resources will be created | `string` | n/a | yes |
| <a name="input_deployment_template"></a> [deployment\_template](#input\_deployment\_template) | Deployment Pattern to use for Cloud resources and CDP | `string` | n/a | yes |
| <a name="input_env_prefix"></a> [env\_prefix](#input\_env\_prefix) | Shorthand name for the environment. Used in resource descriptions | `string` | n/a | yes |
| <a name="input_ingress_extra_cidrs_and_ports"></a> [ingress\_extra\_cidrs\_and\_ports](#input\_ingress\_extra\_cidrs\_and\_ports) | List of extra CIDR blocks and ports to include in Security Group Ingress rules | <pre>object({<br/>    cidrs = list(string)<br/>    ports = list(number)<br/>  })</pre> | n/a | yes |
| <a name="input_cdp_groups"></a> [cdp\_groups](#input\_cdp\_groups) | List of CDP Groups to be added to the IDBroker mappings of the environment. If create\_group is set to true then the group will be created. | <pre>set(object({<br/>    name                          = string<br/>    create_group                  = bool<br/>    sync_membership_on_user_login = optional(bool)<br/>    add_id_broker_mappings        = bool<br/>    })<br/>  )</pre> | `null` | no |
| <a name="input_cdp_private_subnet_ids"></a> [cdp\_private\_subnet\_ids](#input\_cdp\_private\_subnet\_ids) | List of private subnet ids. Required if create\_vpc is false. | `list(any)` | `null` | no |
| <a name="input_cdp_public_subnet_ids"></a> [cdp\_public\_subnet\_ids](#input\_cdp\_public\_subnet\_ids) | List of public subnet ids. Required if create\_vpc is false. | `list(any)` | `null` | no |
| <a name="input_cdp_vpc_id"></a> [cdp\_vpc\_id](#input\_cdp\_vpc\_id) | VPC ID for CDP environment. Required if create\_vpc is false. | `string` | `null` | no |
| <a name="input_compute_cluster_configuration"></a> [compute\_cluster\_configuration](#input\_compute\_cluster\_configuration) | Kubernetes configuration for the externalized compute cluster | <pre>map(object({<br/>    kube_api_authorized_ip_ranges = optional(set(string))<br/>    private_cluster               = optional(bool)<br/>    worker_node_subnets           = optional(set(string))<br/>  }))</pre> | `null` | no |
| <a name="input_compute_cluster_enabled"></a> [compute\_cluster\_enabled](#input\_compute\_cluster\_enabled) | Enable externalized compute cluster for the environment | `bool` | `false` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Flag to specify if the VPC should be created | `bool` | `true` | no |
| <a name="input_datalake_async_creation"></a> [datalake\_async\_creation](#input\_datalake\_async\_creation) | Flag to specify if Terraform should wait for CDP datalake resource creation/deletion | `bool` | `false` | no |
| <a name="input_env_tags"></a> [env\_tags](#input\_env\_tags) | Tags applied to pvovisioned resources | `map(any)` | `null` | no |
| <a name="input_environment_async_creation"></a> [environment\_async\_creation](#input\_environment\_async\_creation) | Flag to specify if Terraform should wait for CDP environment resource creation/deletion | `bool` | `false` | no |
| <a name="input_environment_type"></a> [environment\_type](#input\_environment\_type) | Type of environment to create - Options are HYBRID or PUBLIC\_CLOUD | `string` | `null` | no |
| <a name="input_private_network_extensions"></a> [private\_network\_extensions](#input\_private\_network\_extensions) | Enable creation of resources for connectivity to CDP Control Plane (public subnet and NAT Gateway) for Private Deployment. Only relevant for private deployment template | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->