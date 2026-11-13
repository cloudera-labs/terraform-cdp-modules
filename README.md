# Terraform Modules for Cloudera Prerequisites

This repository contains Terraform modules for creating prerequisite cloud resources on AWS, Azure, and GCP, and deploying Cloudera on cloud.

## Modules

| Module name | Description |
| ----------- | ----------- |
| [terraform-cdp-aws-pre-reqs](modules/terraform-cdp-aws-pre-reqs/README.md) | For all AWS pre-requisite Cloud resources |
| [terraform-cdp-azure-pre-reqs](modules/terraform-cdp-azure-pre-reqs/README.md) | For all Azure pre-requisite Cloud resources |
| [terraform-cdp-gcp-pre-reqs](modules/terraform-cdp-gcp-pre-reqs/README.md) | For all GCP pre-requisite Cloud resources |
| [terraform-cdp-deploy](modules/terraform-cdp-deploy/README.md) | For deploying Cloudera on AWS, Azure, or GCP. |
| [terraform-aws-cred-permissions](modules/terraform-aws-cred-permissions/README.md) | Module for creation of the Cross Account Credential pre-requisite on AWS. Note that this module is called from the terraform-cdp-aws-prereqs module. |
| [terraform-aws-permissions](modules/terraform-aws-permissions/README.md) | Module for creating the AWS IAM permissions required by Cloudera on AWS and its data lake deployment. This module is called from the terraform-cdp-aws-prereqs module. |
| [terraform-aws-ingress](modules/terraform-aws-ingress/README.md) | Module for creation and management of the Default and Knox AWS security groups for Cloudera on cloud deployments. Note that this module is called from the terraform-cdp-aws-prereqs module. |
| [terraform-aws-storage](modules/terraform-aws-storage/) | Module for creating or reusing S3 storage buckets for Cloudera on AWS. Handles data, log, and backup buckets with support for KMS encryption, versioning, and public access blocks. This module is called from the terraform-cdp-aws-prereqs module. |
| [terraform-aws-vpc](modules/terraform-aws-vpc/README.md) | Module for creating VPC networking resources on AWS. Can be used to create the Cloudera VPC and subnets. This module is called from the terraform-cdp-aws-prereqs module. |
| [terraform-aws-fw-vpc](modules/terraform-aws-fw-vpc/README.md) | Module for creating VPC networking resources on AWS, suitable for running a firewall in a distributed architecture. Can create a networking VPC that runs the AWS Network Firewall and connects to a fully private Cloudera on AWS deployment. |
| [terraform-aws-tgw](modules/terraform-aws-tgw/README.md) | Module for creation of AWS Transity Gateway (TGW) and attaching a specified list of VPCs via the TGW. This module can assist with a fully private Cloudera on AWS deployment, where the Cloudera VPC and networking VPC are connected using the Transit Gateway. |
| [terraform-aws-bastion](modules/terraform-aws-bastion/README.md) | Module to create a Bastion EC2 instance on AWS. This module can assist with a secure Cloudera on AWS deployment that requires a Bastion host. |
| [terraform-aws-cml-permissions](modules/terraform-aws-cml-permissions/README.md) | Module to create AWS IAM policies required for backup and restore for Cloudera AI. |
| [terraform-aws-permissions](modules/terraform-aws-permissions/README.md) | Module for creating the AWS IAM permissions required by Cloudera on AWS and its data lake deployment. This module is called from the terraform-cdp-aws-prereqs module. |
| [terraform-aws-firewall](modules/terraform-aws-firewall/README.md) | Module to create and configure an AWS Network Firewall. This module can assist with a fully private Cloudera on AWS deployment, where the Cloudera environment is connected to a networking VPC running the firewall. |
| [terraform-azure-resource-group](modules/terraform-azure-resource-group/README.md) | Module for creating an Azure Resource Group. Can be used to create the prerequisite resource group for Cloudera on Azure. |
| [terraform-azure-ingress](modules/terraform-azure-ingress/README.md) | Module for creating and managing the default and Knox Azure network security groups for Cloudera on cloud deployments. This module is called from the terraform-cdp-azure-prereqs module. |
| [terraform-azure-vnet](modules/terraform-azure-vnet/README.md) | Module for creating an Azure Virtual Network and subnets for Cloudera on Azure. |
| [terraform-azure-cred-permissions](modules/terraform-azure-cred-permissions/README.md) | Module for creating the cross-account credential prerequisites on Azure. This module is called from the terraform-cdp-azure-prereqs module. |
| [terraform-azure-permissions](modules/terraform-azure-permissions/README.md) | Module for creating the Azure Managed Identity and role assignments required for Cloudera on Azure. This module is called from the terraform-cdp-azure-prereqs module. |
| [terraform-azure-bastion](modules/terraform-azure-bastion/README.md) | Module to create a Bastion Virtual Machine instance on Azure. |
| [terraform-azure-nfs](modules/terraform-azure-nfs/README.md) | Module for creating the Azure NFS file share required for Cloudera AI on cloud. It can also create a virtual machine to mount the share and set the required ownership for the Cloudera AI Workbench projects folder.|
| [terraform-azure-cdw-permissions](modules/terraform-azure-cdw-permissions/README.md) | Module for creating the Azure Kubernetes Service managed identity required for Cloudera Data Warehouse.|
| [terraform-azure-cde-permissions](modules/terraform-azure-cde-permissions/README.md) | Module for creating the Azure managed identity required for Cloudera Data Engineering.|
| [terraform-azure-storage](modules/terraform-azure-storage/README.md) | Module for creating the Azure Storage Accounts and containers required for Cloudera on Azure. This module is called from the terraform-cdp-azure-prereqs module.|
| [terraform-azure-storage-endpoints](modules/terraform-azure-storage-endpoints/README.md) | Module for creating Azure private endpoints between specified storage accounts and VNet subnets.|
| [terraform-gcp-api-service](modules/terraform-gcp-api-service/README.md) | Module to enable and validate the required GCP API services for Cloudera on GCP. It can enable APIs or check whether they are already enabled.|

Each module contains Terraform resource configuration and example variable definition files.

## Usage

The [cdp-tf-quickstarts](https://github.com/cloudera-labs/cdp-tf-quickstarts) repository demonstrates how to use the modules together to deploy Cloudera on different cloud environments.

Each module also has a set of examples to show different configuration options for that module.

## Deployment

### Create infrastructure

The instructions below create prerequisite resources and deploy Cloudera together. The modules can also be used independently for further customization.

1. Clone this repository using the following commands:

```bash
git clone https://github.com/cloudera-labs/terraform-cdp-modules.git
cd terraform-cdp-modules
```

2. To create cloud prerequisite resources and deploy Cloudera together, change to the [terraform-cdp-deploy directory](./modules/terraform-cdp-deploy) and select a cloud provider.

```bash
cd modules/terraform-cdp-deploy/examples/ex<deployment_type>/
```

3. Create a `terraform.tfvars` file with variable definitions to run the module. Reference the `terraform.tfvars.sample` file in each example folder to create this file.

4. Run the Terraform module for the chosen deployment type:

```bash
terraform init
terraform apply
```

Once deployment completes, you can create Cloudera Data Hubs and Data Services from the console at https://cdp.cloudera.com/.

## Clean up the infrastructure

If you no longer need the infrastructure that’s provisioned by the Terraform module, run the following command to remove the deployment infrastructure and terminate all resources.

```bash
terraform destroy
```

## Dependencies

To set up Cloudera using deployment automation, install the following dependencies in your local environment:

* Terraform can be installed by following the instructions at https://developer.hashicorp.com/terraform/downloads

Configure Terraform Provider for AWS, Azure or GCP

* Configure the Cloudera Terraform provider with an access key ID and private key by downloading or creating a Cloudera configuration file.
  * See the [Cloudera documentation for generating an API access key](https://docs.cloudera.com/cdp-public-cloud/cloud/cli/topics/mc-cli-generating-an-api-access-key.html).
  * See the [Cloudera Terraform provider documentation](https://registry.terraform.io/providers/cloudera/cdp/latest/docs#authentication) and [DEVELOPMENT.md](./DEVELOPMENT.md) for the supported authentication methods.
  
* To create resources in the Cloud Provider, access credentials or service account are needed for authentication.
  * For **AWS** access keys are required to be able to create the Cloud resources via the Terraform aws provider. See the [AWS Terraform Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration).
  * For **Azure**, authentication with the Azure subscription is required. There are a number of ways to do this outlined in the [Azure Terraform Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure).
  * For **GCP**, authentication with the GCP API is required. There are a number of ways to do this outlined in the [Google Terraform Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication).

### Notes on Azure authentication

* Where you have more than one Azure Subscription the id to use can be passed via the the `ARM_SUBSCRIPTION_ID` environment variable.

* When using a Service Principal (SP) to authenticate with Azure, it is not possible to authenticate with azuread Terraform Provider (the provider used to create the Azure Cross Account AD Application) with the command az login --service-principal. We found the the best way to authenticate using an SP is by setting environment variables. Details of required environment variables are in the [azuread docs](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/guides/service_principal_client_secret#environment-variables) and [azurerm docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#configuring-the-service-principal-in-terraform) and summarized below.
```bash
export ARM_CLIENT_ID="<sp_client_id>"
export ARM_CLIENT_SECRET="<sp_client_secret>"
export ARM_TENANT_ID="<sp_tenant_id>"
export ARM_SUBSCRIPTION_ID="<sp_subscription_id>" 
```

### Notes on GCP authentication

As outlined in the [Getting Started Docs for Google Terraform Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#adding-credentials) there are two recommended ways to authenticate with the GCP API.

1. The Google Cloud SDK (`gcloud`) can be installed and a User Application Default Credentials ("ADCs") can be created by running the command `gcloud auth application-default login`

2. A Google Cloud Service Account key file can be generated and downloaded. The `GOOGLE_APPLICATION_CREDENTIALS` environment variable can then be set to the location of the file.
```bash
export GOOGLE_APPLICATION_CREDENTIALS=<location_of_gcp_sa_json_file>
```

The Google project Id can be specified via the Google provider configuration variable or the `GOOGLE_PROJECT` environment variable. This is described in the [Google Provider Default Values Configuration](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#provider-default-values-configuration) documentation.

## Local Development Environment

See the [DEVELOPMENT.md](./DEVELOPMENT.md) file for instructions on how to set up an environment for local development of modules.