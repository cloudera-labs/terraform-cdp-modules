# Copyright 2024 Cloudera, Inc. All Rights Reserved.
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

locals {
  # Create an endpoint list for each subnet - storage account pair
  endpoints_required = flatten([
    for stor in var.private_endpoint_storage_account_ids : [
      for sbt in var.private_endpoint_target_subnet_ids : {
        subnet_id          = sbt
        storage_account_id = stor
      }
    ]
  ])
}

