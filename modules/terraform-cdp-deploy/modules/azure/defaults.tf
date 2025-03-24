# Copyright 2025 Cloudera, Inc. All Rights Reserved.
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
  # Determine the name of the cross account credential
  cdp_xacccount_credential_name = (
    var.create_cdp_credential == false ?
    var.cdp_xacccount_credential_name :
    cdp_environments_azure_credential.cdp_cred[0].credential_name
  )

  # Construct IDBroker mappings
  cdp_group_id_broker_mappings = [
    for grp, grp_details in coalesce(var.cdp_groups, []) :
    {
      accessor_crn = data.cdp_iam_group.cdp_groups[grp_details.name].crn
      role         = var.datalakeadmin_identity_id
    }
    if try(grp_details.add_id_broker_mappings, false)
  ]
}