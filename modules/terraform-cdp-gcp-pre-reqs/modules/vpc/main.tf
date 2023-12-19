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


# ------- VPC Network -------
resource "google_compute_network" "cdp_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

# ------- Subnets -------
resource "google_compute_subnetwork" "cdp_subnets" {

  for_each = { for idx, subnet in local.cdp_subnets : idx => subnet }

  network = google_compute_network.cdp_network.id
  name    = each.value.name

  ip_cidr_range = each.value.cidr

  private_ip_google_access = var.cdp_subnet_private_ip_google_access

}
