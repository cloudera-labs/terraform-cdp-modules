<!-- BEGIN_TF_DOCS -->
# Example 07: Cloudera on GCP Hybrid Environment

This example demonstrates how to deploy a Cloudera Hybrid environment on GCP. Cloudera Hybrid Environments provide the ability to federate access to data and run workloads across both on-premises and cloud environments.

For more information, see the [Cloudera Hybrid Cloud Overview](https://docs.cloudera.com/hybrid-cloud/latest/overview/topics/hc-overview.html).

## Usage

### 1. Clone the Repository

```bash
git clone https://github.com/cloudera-labs/terraform-cdp-modules.git
cd terraform-cdp-modules/modules/terraform-cdp-deploy/examples/ex07-gcp-hybrid
```

### 2. Configure Variables

Copy the sample variables file and customize it:

```bash
cp terraform.tfvars.sample terraform.tfvars
```

Edit `terraform.tfvars` and provide values for the required variables:

```hcl
env_prefix = "myenv"                    # Environment name prefix (max 12 chars)
gcp_project = "<ENTER_VALUE>" # Change this to specify the GCP Project ID

gcp_region = "europe-west2"

public_key_text = "ssh-rsa AAA...." # Change this with the SSH public key text

deployment_template = "semi-private"    # Options: public, semi-private, or private

# Network ingress settings
ingress_extra_cidrs_and_ports = {
  cidrs = ["203.0.113.0/32"]
  ports = [443, 22]
}
```

### 3. Set GCP and Cloudera Credentials

Configure your **Cloudera API credentials**, by following the steps for [Generating an API access key](https://docs.cloudera.com/cdp-public-cloud/cloud/cli/topics/mc-cli-generating-an-api-access-key.html).

Authentication with the **GCP API** is required. There are a number of ways to do this outlined in the [Google Terraform Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication)

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

**Warning**: This will delete the CDP environment, and all associated GCP resources including Storage Buckets and their contents.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_cdp"></a> [cdp](#requirement\_cdp) | >= 0.6.1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.12 |
| <a name="requirement_http"></a> [http](#requirement\_http) | ~> 3.2.1 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.5.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 7.28.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cdp_deploy"></a> [cdp\_deploy](#module\_cdp\_deploy) | ../.. | n/a |
| <a name="module_cdp_gcp_prereqs"></a> [cdp\_gcp\_prereqs](#module\_cdp\_gcp\_prereqs) | ../../../terraform-cdp-gcp-pre-reqs | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_template"></a> [deployment\_template](#input\_deployment\_template) | Deployment Pattern to use for Cloud resources and CDP | `string` | n/a | yes |
| <a name="input_env_prefix"></a> [env\_prefix](#input\_env\_prefix) | Shorthand name for the environment. Used in resource descriptions | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | Region which Cloud resources will be created | `string` | n/a | yes |
| <a name="input_ingress_extra_cidrs_and_ports"></a> [ingress\_extra\_cidrs\_and\_ports](#input\_ingress\_extra\_cidrs\_and\_ports) | List of extra CIDR blocks and ports to include in Security Group Ingress rules | <pre>object({<br/>    cidrs = list(string)<br/>    ports = list(number)<br/>  })</pre> | n/a | yes |
| <a name="input_public_key_text"></a> [public\_key\_text](#input\_public\_key\_text) | SSH Public key string for the nodes of the CDP environment | `string` | n/a | yes |
| <a name="input_cdp_groups"></a> [cdp\_groups](#input\_cdp\_groups) | List of CDP Groups to be added to the IDBroker mappings of the environment. If create\_group is set to true then the group will be created. | <pre>set(object({<br/>    name                          = string<br/>    create_group                  = bool<br/>    sync_membership_on_user_login = optional(bool)<br/>    add_id_broker_mappings        = bool<br/>    })<br/>  )</pre> | `null` | no |
| <a name="input_cdp_subnet_names"></a> [cdp\_subnet\_names](#input\_cdp\_subnet\_names) | List of subnet names for CDP Resources. Required if create\_vpc is false. | `list(any)` | `null` | no |
| <a name="input_cdp_vpc_name"></a> [cdp\_vpc\_name](#input\_cdp\_vpc\_name) | Pre-existing VPC Name for CDP environment. Required if create\_vpc is false. | `string` | `null` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Flag to specify if the VPC should be created | `bool` | `true` | no |
| <a name="input_datalake_async_creation"></a> [datalake\_async\_creation](#input\_datalake\_async\_creation) | Flag to specify if Terraform should wait for CDP datalake resource creation/deletion | `bool` | `false` | no |
| <a name="input_env_tags"></a> [env\_tags](#input\_env\_tags) | Tags applied to pvovisioned resources | `map(any)` | `null` | no |
| <a name="input_environment_async_creation"></a> [environment\_async\_creation](#input\_environment\_async\_creation) | Flag to specify if Terraform should wait for CDP environment resource creation/deletion | `bool` | `false` | no |
| <a name="input_environment_type"></a> [environment\_type](#input\_environment\_type) | Type of environment to create - Options are HYBRID or PUBLIC\_CLOUD | `string` | `null` | no |
| <a name="input_gcp_project"></a> [gcp\_project](#input\_gcp\_project) | Region which Cloud resources will be created. Can also be set via gcloud project default or environment variable. | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->