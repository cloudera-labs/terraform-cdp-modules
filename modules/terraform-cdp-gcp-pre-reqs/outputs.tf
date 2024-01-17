# Copyright 2023 Cloudera, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

output "gcp_vpc_name" {
  value = local.cdp_vpc_name

  description = "GCP VPC Network name"
}

output "gcp_cdp_subnet_names" {
  value = local.cdp_subnet_names

  description = "GCP VPC Subnet Names for CDP Resources"
}

output "gcp_firewall_default_id" {
  value = google_compute_firewall.cdp_default_fw.id

  description = "GCP Default Firewall Rule ID"
}

output "gcp_firewall_default_name" {
  value = google_compute_firewall.cdp_default_fw.name

  description = "GCP Default Firewall Rule Name"
}

output "gcp_firewall_knox_id" {
  value = google_compute_firewall.cdp_knox_fw.id

  description = "GCP Knox Firewall Rule ID"
}

output "gcp_firewall_knox_name" {
  value = google_compute_firewall.cdp_knox_fw.name

  description = "GCP Knox Firewall Rule Name"
}

output "gcp_data_storage_location" {
  value = google_storage_bucket.cdp_storage_locations[local.data_storage_bucket].url

  description = "GCP data storage location"

}

output "gcp_log_storage_location" {
  value = google_storage_bucket.cdp_storage_locations[local.log_storage_bucket].url

  description = "GCP log storage location"

}

output "gcp_backup_storage_location" {
  value = google_storage_bucket.cdp_storage_locations[local.backup_storage_bucket].url

  description = "GCP log storage location"

}

output "gcp_xaccount_sa_public_key" {
  value = google_service_account_key.cdp_xaccount_sa_key.public_key

  description = "Base64 encoded public key of the GCP Cross Account Service Account Key"
}

output "gcp_xaccount_sa_private_key" {
  value = google_service_account_key.cdp_xaccount_sa_key.private_key

  description = "Base64 encoded private key of the GCP Cross Account Service Account Key"
}

output "gcp_idbroker_service_account_email" {
  value = google_service_account.cdp_idbroker_sa.email

  description = "Email id of the service account for IDBroker"
}

output "gcp_datalake_admin_service_account_email" {
  value = google_service_account.cdp_datalake_admin_sa.email

  description = "Email id of the service account for Datalake Admin"
}

output "gcp_ranger_audit_service_account_email" {
  value = google_service_account.cdp_ranger_audit_sa.email

  description = "Email id of the service account for Ranger Audit"
}

output "gcp_log_service_account_email" {
  value = google_service_account.cdp_log_sa.email

  description = "Email id of the service account for Log Storage"

}
