# Terraform Modules for CDP Prerequisites

This repository contains a number of Terraform modules for creation of the pre-requisite Cloud resources on AWS, Azure and GCP and the deployment of Cloudera Data Platform (CDP) Public Cloud.

## Modules

| Module name | Description |
| ----------- | ----------- |
| [terraform-cdp-aws-pre-reqs](modules/terraform-cdp-aws-pre-reqs/README.md) | For all AWS pre-requisite Cloud resources |
| [terraform-cdp-azure-pre-reqs](modules/terraform-cdp-azure-pre-reqs/README.md) | For all Azure pre-requisite Cloud resources |
| [terraform-cdp-gcp-pre-reqs](modules/terraform-cdp-gcp-pre-reqs/README.md) | For all GCP pre-requisite Cloud resources |
| [terraform-cdp-deploy](modules/terraform-cdp-deploy/README.md) | For deployment of CDP on AWS, Azure or GCP. |
| [terraform-aws-cred-permissions](modules/terraform-aws-cred-permissions/README.md) | Module for creation of the Cross Account Credential pre-requisite on AWS. Note that this module is called from the terraform-cdp-aws-prereqs module. |
| [terraform-aws-permissions](modules/terraform-aws-permissions/README.md) | Module for creation of the AWS IAM permissions required by the (CDP) Public Cloud environment and datalake deployment. Note that this module is called from the terraform-cdp-aws-prereqs module. |
| [terraform-aws-vpc](modules/terraform-aws-vpc/README.md) | Module for creation of the VPC networking resources on AWS. Can be used to create the CDP VPC and Subnets. Note that this module is called from the terraform-cdp-aws-prereqs module. |
| [terraform-aws-fw-vpc](modules/terraform-aws-fw-vpc/README.md) | Module for creation of the VPC networking resources on AWS suitable for running a Firewall in a distributed architecture on AWS. Can be used to create a networking VPC which runs the AWS Network Firewall and connects to a Cloudera on cloud full-private deployment. |
| [terraform-aws-tgw](modules/terraform-aws-tgw/README.md) | Module for creation of AWS Transity Gateway (TGW) and attaching a specified list of VPCs via the TGW. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a fully private networking configuration where a CDP VPC and Networking VPC are connected using the Transit Gateway. |
| [terraform-aws-bastion](modules/terraform-aws-bastion/README.md) | Module to create a Bastion EC2 instance on AWS. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a secure environment, where the CDP Environment requires a Bastion host. |
| [terraform-aws-proxy](modules/terraform-aws-proxy/README.md) | Module to create and configure and EC2 Auto-Scaling Group for a highly available Squid Proxy service with Network Load Balancer (NLB) to forward traffic to the proxy instances. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a fully private networking configuration where a the CDP Environments uses a proxy config via the NLB. |
| [terraform-aws-firewall](modules/terraform-aws-firewall/README.md) | Module to create and configure to create and configure an AWS Network Firewall. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a fully private networking configuration where the CDP Environment is connected to a Networking VPC running the Firewall. |
| [terraform-azure-nfs](modules/terraform-azure-nfs/README.md) | Module for creation of Azure NFS File Share required for Cloudera Machine Learning (CML) Public Cloud. Also optionally creates a Virtual Machine which can be used to mount and set the required ownership for CML workspace's projects folder.|
| [terraform-azure-cdw-permissions](modules/terraform-azure-cdw-permissions/README.md) | Module for creation of the Azure Kubernetes Service (AKS) managed identity required for the Cloudera Data Warehouse (CDW) service.|
| [terraform-azure-storage-endpoints](modules/terraform-azure-storage-endpoints/README.md) | Module for creation creation of Azure private endpoints between specified storage accounts and VNet subnets.|

Each module contains Terraform resource configuration and example variable definition files.

## Usage

The [cdp-tf-quickstarts](https://github.com/cloudera-labs/cdp-tf-quickstarts) repository demonstrates how to use the modules together to deploy CDP on different cloud environments.

Each module also has a set of examples to show different configuration options for that module.

## Deployment

### Create infrastructure

Note that the instructions below give the steps to create pre-requisite resources and the CDP deployment all together. The modules can be used on their own to allow further customization.

1. Clone this repository using the following commands:

```bash
git clone https://github.com/cloudera-labs/terraform-cdp-modules.git
cd terraform-cdp-modules
```

2. To create cloud pre-requisite resources and the CDP deployment all together, change to the [terraform-cdp-deploy directory](./modules/terraform-cdp-deploy) and select one of the cloud providers.

```bash
cd modules/terraform-cdp-deploy/examples/ex<deployment_type>/
```

3. Create a `terraform.tfvars` file with variable definitions to run the module. Reference the `terraform.tfvars.sample` file in each example folder to create this file.

4. Run the Terraform module for the chosen deployment type:

```bash
terraform init
terraform apply
```

Once the deployment completes, you can create CDP Data Hubs and Data Services from the CDP Management Console (https://cdp.cloudera.com/).

## Clean up the infrastructure

If you no longer need the infrastructure that’s provisioned by the Terraform module, run the following command to remove the deployment infrastructure and terminate all resources.

```bash
terraform destroy
```

## Dependencies

To set up CDP via deployment automation using this guide, the following dependencies must be installed in your local environment:

* Terraform can be installed by following the instructions at https://developer.hashicorp.com/terraform/downloads

Configure Terraform Provider for AWS, Azure or GCP

* Configure the Terraform Provider for CDP with access key ID and private key by dowloading or creating a CDP configuation file.
  * See the [CDP documentation for steps to Generate the API access key](https://docs.cloudera.com/cdp-public-cloud/cloud/cli/topics/mc-cli-generating-an-api-access-key.html).
  * See the [CDP Terraform Provider Documentation](https://registry.terraform.io/providers/cloudera/cdp/latest/docs#authentication) and [DEVELOPMENT.md](./DEVELOPMENT.md) for the different ways of providing the CDP credentials for authentication.
  
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