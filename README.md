# Terraform Modules for CDP Prerequisites

This repository contains a number of Terraform modules for creation of the pre-requisite Cloud resources on AWS and Azure and the deployment of Cloudera Data Platform (CDP) Public Cloud.

## Modules

| Module name | Description |
| ----------- | ----------- |
| [terraform-cdp-aws-prereqs](modules/terraform-cdp-aws-pre-reqs/README.md) | For all AWS pre-requisite Cloud resources |
| [terraform-cdp-azure-prereqs](modules/terraform-cdp-azure-pre-reqs/README.md) | For all Azure pre-requisite Cloud resources |
| [terraform-cdp-deploy](modules/terraform-cdp-deploy/README.md) | For deployment of CDP on Azure or AWS. |
| [terraform-aws-vpc](modules/terraform-aws-vpc/README.md) | Module for creation of the VPC networking resources on AWS suitable. Can be used to create the CDP VPC and Subnets. Note that this module is called from the terraform-cdp-aws-prereqs module. |
| [terraform-aws-tgw](modules/terraform-aws-tgw/README.md) | Module for creation creation of AWS Transity Gateway (TGW) and attaching a specified list of VPCs via the TGW. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a fully private networking configuration where a CDP VPC and Networking VPC are connected using the Transit Gateway. |
| [terraform-aws-proxy](modules/terraform-aws-proxy/README.md) | Module for creation of an EC2 Auto-Scaling Group and NLB for a highly available Squid Proxy service. Can be used to create the CDP VPC and Subnets. This module can be used to assist in deploying Cloudera Data Platform (CDP) Public Cloud in a fully private networking configuration. |

Each module contains Terraform resource configuration and example variable definition files.

* For AWS pre-requisite Cloud resources see [terraform-cdp-aws-prereqs](modules/terraform-cdp-aws-pre-reqs/README.md).
* For Azure pre-requisite Cloud resources see [terraform-cdp-azure-prereqs](modules/terraform-cdp-azure-pre-reqs/README.md).
* For deployment of CDP on Azure or AWS see [terraform-cdp-deploy](modules/terraform-cdp-deploy/README.md).

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

## External dependencies

The module includes the option to discover the cross account Ids and to run the CDP deployment using external tools.

To utilize these options extra requirements are needed - Python 3, Ansible 2.12, the CDP CLI, the [jq utility](https://stedolan.github.io/jq/download/) and a number of support Python libraries and Ansible collections.

A summary of the install and configuration steps for these additional requirements is given below.
We recommend these steps be performed within an Python virtual environment.

```bash
# Install jq as per instructions at https://stedolan.github.io/jq/download/
# Example for MacOS using homebew shown below
brew install jq

# Install the Ansible core Python package
pip install ansible-core==2.12.10 jmespath==1.0.1

# Install cdpy, a Pythonic wrapper for Cloudera CDP CLI. This in turn installs the CDP CLI.
pip install git+https://github.com/cloudera-labs/cdpy@main#egg=cdpy

# Install the cloudera.cloud Ansible Collection
ansible-galaxy collection install git+https://github.com/cloudera-labs/cloudera.cloud.git,devel

# Install the community.general Ansible Collection
ansible-galaxy collection install community.general:==5.5.0

# Configure cdp with CDP API access key ID and private key
cdp configure
```

NOTE - See the [CDP documentation for steps to Generate the API access key](https://docs.cloudera.com/cdp-public-cloud/cloud/cli/topics/mc-cli-generating-an-api-access-key.html) required in the `cdp configure` command above.
