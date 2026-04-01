# Example 04: Cloudera on AWS Deployment with Custom IAM Policy Documents

This example demonstrates how to deploy a Cloudera on AWS environment and datalake using custom IAM policy documents. This approach allows you to specify minimal resource access policies as local static JSON files, providing fine-grained control over the permissions granted to CDP.

This example shows how to:

- Use local JSON files to define custom IAM policies
- Pass these custom policies to the `terraform-cdp-aws-pre-reqs` module
- Deploy a complete CDP environment with minimal required permissions

The custom policies in this example are based on Cloudera's documented [reduced access credential policy requirements](https://docs.cloudera.com/cdp-public-cloud/cloud/requirements-aws/topics/mc-aws-req-credential.html).

## Custom Policy Documents

This example includes the following custom IAM policy documents in the [policy_docs](policy_docs) directory:

| Policy File | Purpose |
|------------|---------|
| `aws-environment-minimal-policy.json` | Cross-account policy for the CDP credential with minimal required permissions |
| `aws-cdp-idbroker-assume-role-policy.json` | Trust policy for the IDBroker role to assume other roles |
| `aws-cdp-log-policy.json` | Policy for log data access |
| `aws-cdp-bucket-access-policy.json` | Base S3 bucket access policy for data, logs, and backups |
| `aws-cdp-datalake-admin-s3-policy.json` | Policy for datalake admin role S3 access |
| `aws-cdp-ranger-audit-s3-policy.json` | Policy for Ranger audit log access to S3 |
| `aws-datalake-backup-policy.json` | Policy for datalake backup operations |
| `aws-datalake-restore-policy.json` | Policy for datalake restore operations |

## How It Works

The example uses Terraform's `local_file` data source to read the policy JSON files and pass their content to the `terraform-cdp-aws-pre-reqs` module:

```hcl
# Read policy document from local file
data "local_file" "xaccount_env_policy_doc" {
  filename = "./policy_docs/aws-environment-minimal-policy.json"
}

# Pass to pre-reqs module
module "cdp_aws_prereqs" {
  source = "../../../terraform-cdp-aws-pre-reqs"
  
  # ... other variables ...
  
  xaccount_account_policy_doc = data.local_file.xaccount_env_policy_doc.content
  idbroker_policy_doc = data.local_file.idbroker_assume_role_policy_doc.content
  data_bucket_access_policy_doc = data.local_file.bucket_access_policy_doc.content
  # ... additional policy documents ...
}
```

## Usage

### 1. Clone the Repository

```bash
git clone https://github.com/cloudera-labs/terraform-cdp-modules.git
cd terraform-cdp-modules/modules/terraform-cdp-deploy/examples/ex04-aws-custom-policies
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

### 3. (Optional) Customize Policy Documents

Review and modify the policy JSON files in the `policy_docs/` directory to match your organization's security requirements. Ensure that:

- Resource placeholders (e.g., bucket ARNs) are updated if needed
- Permissions align with your CDP workload requirements
- Policies comply with your organization's security standards

**Note**: The policies must include the minimum permissions required by CDP. Refer to the [Cloudera documentation](https://docs.cloudera.com/cdp-public-cloud/cloud/requirements-aws/topics/mc-aws-req-credential.html) for details.

### 4. Set AWS and Cloudera Credentials

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
- Checking the AWS console for created resources
- Reviewing IAM roles and policies to confirm custom policies are applied

## Resource Cleanup

To destroy all created resources:

```bash
terraform destroy
```

**Warning**: This will delete the CDP environment, datalake, and all associated AWS resources including S3 buckets and their contents.
