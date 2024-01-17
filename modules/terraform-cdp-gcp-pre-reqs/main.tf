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

# ------- VPC -------
# Create the VNet & subnets if required
module "gcp_cdp_vpc" {
  count = var.create_vpc ? 1 : 0

  source = "./modules/vpc"

  vpc_name     = local.vpc_name
  vpc_cidr     = var.vpc_cidr
  subnet_count = var.subnet_count

  env_prefix = var.env_prefix

  cdp_subnet_private_ip_google_access = local.cdp_subnet_private_ip_google_access

}

# ------- VPC Peering to GCP Services-------
# Address range for peering to GCP Services
resource "google_compute_global_address" "google_managed_services" {
  name          = local.managed_services_global_address_name
  description   = "Global address range for VPC Peering to Google Managed Services for ${var.env_prefix}"
  address_type  = "INTERNAL"
  purpose       = "VPC_PEERING"
  address       = split("/", var.managed_services_global_address_cidr)[0]
  prefix_length = split("/", var.managed_services_global_address_cidr)[1]
  # labels        = local.env_tags # TODO: Beta provider feature
  network = local.cdp_vpc_name
}

resource "google_service_networking_connection" "google_managed_services" {
  network                 = local.cdp_vpc_name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.google_managed_services.name]
}

# ------- Security Groups / Firewall Rules -------
# Default Allow Internal
resource "google_compute_firewall" "cdp_allow_internal_fw" {
  name      = local.firewall_internal_name
  network   = local.cdp_vpc_name
  direction = "INGRESS"
  priority  = 65534

  description = "Allow internal traffic on the network"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }

  # TODO: How to determine vpc_cidr when e.g. create_vpc = False
  source_ranges = [var.vpc_cidr]
}

# CDP Default Firewall
resource "google_compute_firewall" "cdp_default_fw" {
  name      = local.firewall_default_name
  network   = local.cdp_vpc_name
  direction = "INGRESS"
  priority  = 100

  description = "Default Firewall for CDP environment"

  allow {
    protocol = "tcp"
    ports    = var.ingress_extra_cidrs_and_ports.ports
  }

  source_ranges = var.ingress_extra_cidrs_and_ports.cidrs

}

# CDP Knox Firewall
resource "google_compute_firewall" "cdp_knox_fw" {
  name      = local.firewall_knox_name
  network   = local.cdp_vpc_name
  direction = "INGRESS"
  priority  = 100

  description = "Knox Firewall for CDP environment"

  allow {
    protocol = "tcp"
    ports    = var.ingress_extra_cidrs_and_ports.ports
  }

  source_ranges = var.ingress_extra_cidrs_and_ports.cidrs

}

# ------- Advanced Networking for private deployments -------
resource "google_compute_router" "cdp_compute_router" {

  count = contains(["semi-private", "private"], var.deployment_template) ? 1 : 0


  network = local.cdp_vpc_name
  name    = local.compute_router_name

  bgp {
    asn            = var.compute_router_bgp_settings.asn
    advertise_mode = try(var.compute_router_bgp_settings.advertise_mode, null)
    # TODO: Explore how to expose these variables
    # advertised_groups = coalesce(var.compute_router_bgp_settings.advertised_groups, [])
    # advertised_ip_ranges {
    #   range = try(var.compute_router_bgp_settings.advertised_ip_ranges.range, null)
    #   description = try(var.compute_router_bgp_settings.advertised_ip_ranges.description, null)
    # }      
    keepalive_interval = try(var.compute_router_bgp_settings.keepalive_interval, null)
  }
}

resource "google_compute_router_nat" "cdp_nat" {

  count = contains(["semi-private", "private"], var.deployment_template) ? 1 : 0

  name                               = local.compute_router_nat_name
  router                             = google_compute_router.cdp_compute_router[0].name
  nat_ip_allocate_option             = var.compute_router_nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.compute_router_nat_source_subnetwork_ip_ranges

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

# ------- Storage buckets (GCS) -------
resource "random_id" "bucket_suffix" {
  count = var.random_id_for_bucket ? 1 : 0

  byte_length = 4
}

resource "google_storage_bucket" "cdp_storage_locations" {

  for_each = toset(concat([local.data_storage_bucket], [local.log_storage_bucket], [local.backup_storage_bucket]))

  name = "${each.value}${local.storage_suffix}"

  location      = local.bucket_storage_region
  storage_class = var.bucket_storage_class

  force_destroy = true
}

# ------- GCS Buckets directory structures -------
# Data Storage Objects
# resource "google_storage_bucket_object" "cdp_data_storage_object" {
#   bucket = "${local.data_storage.data_storage_bucket}${local.storage_suffix}"

#   name   = local.data_storage.data_storage_object # folder name should end with '/'

#   content = " "            # content is ignored but should be non-empty

#   depends_on = [
#     google_storage_bucket.cdp_storage_locations
#   ]

# }

# # Log Storage Objects
# resource "google_storage_bucket_object" "cdp_log_storage" {
#   bucket = "${local.log_storage.log_storage_bucket}${local.storage_suffix}"

#   name   = local.log_storage.log_storage_object # folder name should end with '/'

#   content = " "            # content is ignored but should be non-empty

#   depends_on = [
#     google_storage_bucket.cdp_storage_locations
#   ]

# }

# # Backup Storage Object
# resource "google_storage_bucket_object" "cdp_backup_storage" {
#   bucket = "${local.backup_storage.backup_storage_bucket}${local.storage_suffix}"

#   name   = local.backup_storage.backup_storage_object # folder name should end with '/'

#   content = " "            # content is ignored but should be non-empty

#   depends_on = [
#     google_storage_bucket.cdp_storage_locations
#   ]

# }

# ------- GCP Cross Account Service Account -------

#Create GCP xaccount service account
resource "google_service_account" "cdp_xaccount_sa" {

  account_id   = local.xaccount_service_account_id
  display_name = local.xaccount_service_account_name

  description = "CDP Cross Account service account for ${var.env_prefix}"
}

# Grant required roles to the GCP xaccount service account
resource "google_project_iam_member" "cdp_xaccount_sa_binding" {

  for_each = toset(var.xaccount_sa_policies)

  project = data.google_project.project.project_id
  role    = each.value

  member = google_service_account.cdp_xaccount_sa.member
}

# Generate key for the GCP xaccount service account
resource "google_service_account_key" "cdp_xaccount_sa_key" {
  service_account_id = google_service_account.cdp_xaccount_sa.name

}

# ------- GCP Custom Roles -------

# Log Data Access Role
resource "google_project_iam_custom_role" "cdp_log_data_access" {
  role_id     = local.log_data_access_custom_role_id
  title       = local.log_data_access_custom_role_name
  description = "Log Data Access Role for ${var.env_prefix} CDP environment"
  permissions = var.log_role_permissions
}

# Ranger Audit and Datalake Admin Role
resource "google_project_iam_custom_role" "cdp_datalake_admin" {
  role_id     = local.datalake_admin_custom_role_id
  title       = local.datalake_admin_custom_role_name
  description = "Ranger Audit and Datalake Admin Role for ${var.env_prefix} CDP environment"
  permissions = var.datalake_admin_role_permissions
}

# IDBroker Role
resource "google_project_iam_custom_role" "cdp_idbroker" {
  role_id     = local.idbroker_custom_role_id
  title       = local.idbroker_custom_role_name
  description = "IDBroker Role for ${var.env_prefix} CDP environment"
  permissions = var.idbroker_role_permissions
}

# ------- GCP Operational Service Accounts -------

# Log Service Account
resource "google_service_account" "cdp_log_sa" {

  account_id   = local.log_service_account_id
  display_name = local.log_service_account_name

  description = "CDP Log service account for ${var.env_prefix}"
}

# Datalake Admin Service Account
resource "google_service_account" "cdp_datalake_admin_sa" {

  account_id   = local.datalake_admin_service_account_id
  display_name = local.datalake_admin_service_account_name

  description = "CDP Datalake Admin service account for ${var.env_prefix}"
}

# Ranger Audit Service Account
resource "google_service_account" "cdp_ranger_audit_sa" {

  account_id   = local.ranger_audit_service_account_id
  display_name = local.ranger_audit_service_account_name

  description = "CDP Ranger Audit service account for ${var.env_prefix}"
}

# IDBroker Service Account
resource "google_service_account" "cdp_idbroker_sa" {

  account_id   = local.idbroker_service_account_id
  display_name = local.idbroker_service_account_name

  description = "CDP IDBroker service account for ${var.env_prefix}"
}


# ------- Grant required roles to operational service accounts -------

# Grant required roles to the Log service account
resource "google_project_iam_member" "cdp_log_sa_binding" {

  project = data.google_project.project.project_id
  role    = google_project_iam_custom_role.cdp_log_data_access.name

  member = google_service_account.cdp_log_sa.member
}

# Grant required roles to the DataLake Admin service account
resource "google_project_iam_member" "cdp_datalake_admin_sa_binding" {

  project = data.google_project.project.project_id
  role    = google_project_iam_custom_role.cdp_datalake_admin.name

  member = google_service_account.cdp_datalake_admin_sa.member
}

# Grant required roles to the Ranger Audit service account
resource "google_project_iam_member" "cdp_ranger_audit_sa_binding" {

  project = data.google_project.project.project_id
  role    = google_project_iam_custom_role.cdp_datalake_admin.name

  member = google_service_account.cdp_ranger_audit_sa.member
}


# Grant required roles to the IDBroker service account
resource "google_project_iam_member" "cdp_idbroker_sa_binding" {

  project = data.google_project.project.project_id
  role    = google_project_iam_custom_role.cdp_idbroker.name

  member = google_service_account.cdp_idbroker_sa.member
}

# ------- Add Operational Service Accounts as members to the Storage buckets -------

# Give Log SA log data custom role for log and backup buckets
resource "google_storage_bucket_iam_member" "cdp_log_sa_member" {

  for_each = toset([local.log_storage_bucket, local.backup_storage_bucket])

  bucket = "${each.value}${local.storage_suffix}"

  role = google_project_iam_custom_role.cdp_log_data_access.name

  member = google_service_account.cdp_log_sa.member

  depends_on = [
    google_storage_bucket.cdp_storage_locations
  ]
}


# Give Datalake Admin SA DL admin custom role for data and backup buckets
resource "google_storage_bucket_iam_member" "cdp_data_sa_member" {

  for_each = toset([local.data_storage_bucket, local.backup_storage_bucket])

  bucket = "${each.value}${local.storage_suffix}"

  role = google_project_iam_custom_role.cdp_datalake_admin.name

  member = google_service_account.cdp_datalake_admin_sa.member

  depends_on = [
    google_storage_bucket.cdp_storage_locations
  ]
}

# Give Ranger Audit SA DL admin custom role for data bucket
resource "google_storage_bucket_iam_member" "cdp_ranger_audit_sa_member" {

  for_each = toset([local.data_storage_bucket])

  bucket = "${each.value}${local.storage_suffix}"

  role = google_project_iam_custom_role.cdp_datalake_admin.name

  member = google_service_account.cdp_ranger_audit_sa.member

  depends_on = [
    google_storage_bucket.cdp_storage_locations
  ]
}

# ------- Add binding of IDBroker SA to Operational Service Accounts -------

# IDBroker SA policy binding for DL Admin 
resource "google_service_account_iam_member" "cdp_idbroker_dladmin_binding" {

  service_account_id = google_service_account.cdp_datalake_admin_sa.id
  role               = google_project_iam_custom_role.cdp_idbroker.name
  member             = google_service_account.cdp_idbroker_sa.member

}

# IDBroker SA policy binding for Ranger Audit 
resource "google_service_account_iam_member" "cdp_idbroker_ranger_audit_binding" {

  service_account_id = google_service_account.cdp_ranger_audit_sa.id
  role               = google_project_iam_custom_role.cdp_idbroker.name
  member             = google_service_account.cdp_idbroker_sa.member

}
