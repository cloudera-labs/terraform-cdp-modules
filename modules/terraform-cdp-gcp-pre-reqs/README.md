<!-- BEGIN_TF_DOCS -->
# Terraform Module for CDP Prerequisites on GCP

This module contains resource files and example variable definition files for creation of the pre-requisite Google Cloud Platform (GCP) resources required for Cloudera Data Platform (CDP) Public Cloud.

## Usage

The [examples](./examples) directory has example GCP Cloud Service Provider deployments for different scenarios:

* `ex01-minimal-inputs` uses the minimum set of inputs for the module.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 1.3.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.12 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 6.12 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp_cdp_vpc"></a> [gcp\_cdp\_vpc](#module\_gcp\_cdp\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.cdp_allow_internal_fw](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.cdp_default_fw](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.cdp_knox_fw](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_global_address.google_managed_services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_router.cdp_compute_router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.cdp_nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_project_iam_custom_role.cdp_datalake_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cdp_idbroker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_custom_role.cdp_log_data_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.cdp_datalake_admin_sa_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cdp_idbroker_sa_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cdp_log_sa_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cdp_ranger_audit_sa_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cdp_xaccount_sa_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.cdp_datalake_admin_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.cdp_idbroker_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.cdp_log_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.cdp_ranger_audit_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.cdp_xaccount_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.cdp_idbroker_dladmin_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.cdp_idbroker_ranger_audit_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_key.cdp_xaccount_sa_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [google_service_networking_connection.google_managed_services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [google_storage_bucket.cdp_storage_locations](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.cdp_data_sa_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.cdp_log_sa_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.cdp_ranger_audit_sa_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [random_id.bucket_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_template"></a> [deployment\_template](#input\_deployment\_template) | Deployment Pattern to use for Cloud resources and CDP | `string` | n/a | yes |
| <a name="input_env_prefix"></a> [env\_prefix](#input\_env\_prefix) | Shorthand name for the environment. Used in resource descriptions | `string` | n/a | yes |
| <a name="input_backup_storage_bucket"></a> [backup\_storage\_bucket](#input\_backup\_storage\_bucket) | Optional Backup location for CDP environment. | `string` | `null` | no |
| <a name="input_bucket_public_access_prevention"></a> [bucket\_public\_access\_prevention](#input\_bucket\_public\_access\_prevention) | Controls public access to GCS bucket. Acceptable values are inherited or enforced. | `string` | `"enforced"` | no |
| <a name="input_bucket_storage_class"></a> [bucket\_storage\_class](#input\_bucket\_storage\_class) | The GCS storage class to use for the data, log and backup storage | `string` | `"NEARLINE"` | no |
| <a name="input_bucket_storage_region"></a> [bucket\_storage\_region](#input\_bucket\_storage\_region) | The location of the Google Cloud Storage buckets for data, backups and logs. By default this follows the gcp\_region variable. | `string` | `null` | no |
| <a name="input_cdp_subnet_names"></a> [cdp\_subnet\_names](#input\_cdp\_subnet\_names) | List of subnet names. Required if create\_vpc is false. | `list(any)` | `null` | no |
| <a name="input_cdp_vpc_name"></a> [cdp\_vpc\_name](#input\_cdp\_vpc\_name) | VPC Name for CDP environment. Required if create\_vpc is false. | `string` | `null` | no |
| <a name="input_compute_router_bgp_settings"></a> [compute\_router\_bgp\_settings](#input\_compute\_router\_bgp\_settings) | BGP settings used for the Google Compute Router resource in private deployments. | <pre>object({<br>    asn                  = number<br>    advertise_mode       = optional(string)<br>    advertised_groups    = optional(string)<br>    advertised_ip_ranges = optional(list(object({})))<br>    keepalive_interval   = optional(number)<br>  })</pre> | <pre>{<br>  "advertise_mode": "DEFAULT",<br>  "asn": 64514<br>}</pre> | no |
| <a name="input_compute_router_name"></a> [compute\_router\_name](#input\_compute\_router\_name) | Name of the Google Compute Router resource created for private deployment. | `string` | `null` | no |
| <a name="input_compute_router_nat_ip_allocate_option"></a> [compute\_router\_nat\_ip\_allocate\_option](#input\_compute\_router\_nat\_ip\_allocate\_option) | How external IPs should be allocated for Google Compute Router NAT in private deployments. | `string` | `"AUTO_ONLY"` | no |
| <a name="input_compute_router_nat_name"></a> [compute\_router\_nat\_name](#input\_compute\_router\_nat\_name) | Name of the Google Compute Router NAT created for private deployment. | `string` | `null` | no |
| <a name="input_compute_router_nat_source_subnetwork_ip_ranges"></a> [compute\_router\_nat\_source\_subnetwork\_ip\_ranges](#input\_compute\_router\_nat\_source\_subnetwork\_ip\_ranges) | How NAT should be configured per Subnetwork for Google Compute Router NAT in private deployments. | `string` | `"ALL_SUBNETWORKS_ALL_IP_RANGES"` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Flag to specify if the VPC Network should be created | `bool` | `true` | no |
| <a name="input_data_storage_bucket"></a> [data\_storage\_bucket](#input\_data\_storage\_bucket) | Data storage locations for CDP environment | `string` | `null` | no |
| <a name="input_datalake_admin_custom_role_name"></a> [datalake\_admin\_custom\_role\_name](#input\_datalake\_admin\_custom\_role\_name) | Name of Ranger Audit and Datalake Admin Custom Role | `string` | `null` | no |
| <a name="input_datalake_admin_role_permissions"></a> [datalake\_admin\_role\_permissions](#input\_datalake\_admin\_role\_permissions) | List of Permission Assignments to the Ranger Audit and Datalake Admin Custom Role | `list(string)` | <pre>[<br>  "storage.buckets.get",<br>  "storage.objects.create",<br>  "storage.objects.delete",<br>  "storage.objects.get",<br>  "storage.objects.list",<br>  "storage.hmacKeys.create",<br>  "storage.hmacKeys.delete",<br>  "storage.hmacKeys.get",<br>  "storage.hmacKeys.list",<br>  "storage.hmacKeys.update"<br>]</pre> | no |
| <a name="input_datalake_admin_service_account_name"></a> [datalake\_admin\_service\_account\_name](#input\_datalake\_admin\_service\_account\_name) | Datalake Admin service account name | `string` | `null` | no |
| <a name="input_firewall_default_name"></a> [firewall\_default\_name](#input\_firewall\_default\_name) | Name of Default Firewall for CDP environment | `string` | `null` | no |
| <a name="input_firewall_internal_name"></a> [firewall\_internal\_name](#input\_firewall\_internal\_name) | Name of Firewall for Internal Virtual Network communication | `string` | `null` | no |
| <a name="input_firewall_knox_name"></a> [firewall\_knox\_name](#input\_firewall\_knox\_name) | Name of Knox Firewall for CDP environment | `string` | `null` | no |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | Region which Cloud resources will be created | `string` | `null` | no |
| <a name="input_idbroker_custom_role_name"></a> [idbroker\_custom\_role\_name](#input\_idbroker\_custom\_role\_name) | Name of IDBroker Custom Role | `string` | `null` | no |
| <a name="input_idbroker_role_permissions"></a> [idbroker\_role\_permissions](#input\_idbroker\_role\_permissions) | List of Permission Assignments to the IDBroker Custom Role | `list(string)` | <pre>[<br>  "iam.serviceAccounts.getAccessToken",<br>  "iam.serviceAccounts.actAs"<br>]</pre> | no |
| <a name="input_idbroker_service_account_name"></a> [idbroker\_service\_account\_name](#input\_idbroker\_service\_account\_name) | IDBroker service account name | `string` | `null` | no |
| <a name="input_ingress_extra_cidrs_and_ports"></a> [ingress\_extra\_cidrs\_and\_ports](#input\_ingress\_extra\_cidrs\_and\_ports) | List of extra CIDR blocks and ports to include in Security Group Ingress rules | <pre>object({<br>    cidrs = list(string)<br>    ports = list(number)<br>  })</pre> | <pre>{<br>  "cidrs": [],<br>  "ports": []<br>}</pre> | no |
| <a name="input_log_data_access_custom_role_name"></a> [log\_data\_access\_custom\_role\_name](#input\_log\_data\_access\_custom\_role\_name) | Name of Log Data Access Custom Role | `string` | `null` | no |
| <a name="input_log_role_permissions"></a> [log\_role\_permissions](#input\_log\_role\_permissions) | List of Permission Assignments to the Log Data Access Custom Role | `list(string)` | <pre>[<br>  "storage.buckets.get",<br>  "storage.objects.create"<br>]</pre> | no |
| <a name="input_log_service_account_name"></a> [log\_service\_account\_name](#input\_log\_service\_account\_name) | Log service account name | `string` | `null` | no |
| <a name="input_log_storage_bucket"></a> [log\_storage\_bucket](#input\_log\_storage\_bucket) | Optional log locations for CDP environment. | `string` | `null` | no |
| <a name="input_managed_services_global_address_cidr"></a> [managed\_services\_global\_address\_cidr](#input\_managed\_services\_global\_address\_cidr) | CIDR Block for Google Managed Service VPC Peering Connection Address | `string` | `"10.10.192.0/24"` | no |
| <a name="input_managed_services_global_address_name"></a> [managed\_services\_global\_address\_name](#input\_managed\_services\_global\_address\_name) | Name of the Managed Service address used for the Peering Connection to CloudSQL | `string` | `null` | no |
| <a name="input_random_id_for_bucket"></a> [random\_id\_for\_bucket](#input\_random\_id\_for\_bucket) | Create a random suffix for the bucket names | `bool` | `true` | no |
| <a name="input_ranger_audit_service_account_name"></a> [ranger\_audit\_service\_account\_name](#input\_ranger\_audit\_service\_account\_name) | Ranger Audit service account name | `string` | `null` | no |
| <a name="input_subnet_count"></a> [subnet\_count](#input\_subnet\_count) | Number of Subnets Required | `number` | `1` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR Block | `string` | `"10.1.0.0/19"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC name | `string` | `null` | no |
| <a name="input_xaccount_sa_policies"></a> [xaccount\_sa\_policies](#input\_xaccount\_sa\_policies) | List of IAM policies to apply to the Cross Account Service Account | `list(string)` | <pre>[<br>  "roles/iam.serviceAccountUser",<br>  "roles/compute.instanceAdmin.v1",<br>  "roles/storage.admin",<br>  "roles/compute.networkViewer",<br>  "roles/compute.loadBalancerAdmin",<br>  "roles/cloudsql.admin",<br>  "roles/compute.networkUser",<br>  "roles/compute.publicIpAdmin",<br>  "roles/cloudkms.admin"<br>]</pre> | no |
| <a name="input_xaccount_service_account_name"></a> [xaccount\_service\_account\_name](#input\_xaccount\_service\_account\_name) | Cross Account service account name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gcp_backup_storage_location"></a> [gcp\_backup\_storage\_location](#output\_gcp\_backup\_storage\_location) | GCP log storage location |
| <a name="output_gcp_cdp_subnet_names"></a> [gcp\_cdp\_subnet\_names](#output\_gcp\_cdp\_subnet\_names) | GCP VPC Subnet Names for CDP Resources |
| <a name="output_gcp_data_storage_location"></a> [gcp\_data\_storage\_location](#output\_gcp\_data\_storage\_location) | GCP data storage location |
| <a name="output_gcp_datalake_admin_service_account_email"></a> [gcp\_datalake\_admin\_service\_account\_email](#output\_gcp\_datalake\_admin\_service\_account\_email) | Email id of the service account for Datalake Admin |
| <a name="output_gcp_firewall_default_id"></a> [gcp\_firewall\_default\_id](#output\_gcp\_firewall\_default\_id) | GCP Default Firewall Rule ID |
| <a name="output_gcp_firewall_default_name"></a> [gcp\_firewall\_default\_name](#output\_gcp\_firewall\_default\_name) | GCP Default Firewall Rule Name |
| <a name="output_gcp_firewall_knox_id"></a> [gcp\_firewall\_knox\_id](#output\_gcp\_firewall\_knox\_id) | GCP Knox Firewall Rule ID |
| <a name="output_gcp_firewall_knox_name"></a> [gcp\_firewall\_knox\_name](#output\_gcp\_firewall\_knox\_name) | GCP Knox Firewall Rule Name |
| <a name="output_gcp_idbroker_service_account_email"></a> [gcp\_idbroker\_service\_account\_email](#output\_gcp\_idbroker\_service\_account\_email) | Email id of the service account for IDBroker |
| <a name="output_gcp_log_service_account_email"></a> [gcp\_log\_service\_account\_email](#output\_gcp\_log\_service\_account\_email) | Email id of the service account for Log Storage |
| <a name="output_gcp_log_storage_location"></a> [gcp\_log\_storage\_location](#output\_gcp\_log\_storage\_location) | GCP log storage location |
| <a name="output_gcp_ranger_audit_service_account_email"></a> [gcp\_ranger\_audit\_service\_account\_email](#output\_gcp\_ranger\_audit\_service\_account\_email) | Email id of the service account for Ranger Audit |
| <a name="output_gcp_vpc_name"></a> [gcp\_vpc\_name](#output\_gcp\_vpc\_name) | GCP VPC Network name |
| <a name="output_gcp_xaccount_sa_private_key"></a> [gcp\_xaccount\_sa\_private\_key](#output\_gcp\_xaccount\_sa\_private\_key) | Base64 encoded private key of the GCP Cross Account Service Account Key |
| <a name="output_gcp_xaccount_sa_public_key"></a> [gcp\_xaccount\_sa\_public\_key](#output\_gcp\_xaccount\_sa\_public\_key) | Base64 encoded public key of the GCP Cross Account Service Account Key |
<!-- END_TF_DOCS -->