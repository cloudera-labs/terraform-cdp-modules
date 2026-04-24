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
