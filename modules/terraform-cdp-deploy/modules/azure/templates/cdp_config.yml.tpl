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

# CDP environment & DL settings
plat__env_name: ${plat__env_name}
plat__datalake_name: ${plat__datalake_name}
plat__xacccount_credential_name: ${plat__xacccount_credential_name}
plat__cdp_iam_admin_group_name: ${plat__cdp_iam_admin_group_name}
plat__cdp_iam_user_group_name: ${plat__cdp_iam_user_group_name}

plat__datalake_scale: ${plat__datalake_scale}
plat__datalake_version: ${plat__datalake_version}
plat__tunnel: ${plat__tunnel}
plat__endpoint_access_scheme: ${plat__endpoint_access_scheme}
plat__use_public_ips: ${plat__use_public_ips}
plat__enable_raz: ${plat__enable_raz}
plat__use_single_resource_group: ${plat__use_single_resource_group}
plat__workload_analytics: ${plat__workload_analytics}
plat__env_freeipa_instances: ${plat__env_freeipa_instances}
plat__tags: ${plat__tags}

# CDP settings
plat__cdp_profile: ${plat__cdp_profile}
plat__cdp_control_plane_region: ${plat__cdp_control_plane_region}

# CSP settings
plat__infra_type: ${plat__infra_type} 
plat__region: ${plat__region}

plat__azure_subscription_id: ${plat__azure_subscription_id}
plat__azure_tenant_id: ${plat__azure_tenant_id}

plat__azure_vnet_name: ${plat__azure_vnet_name}
plat__azure_resourcegroup_name: ${plat__azure_resourcegroup_name}
plat__azure_subnet_names_for_cdp: ${plat__azure_subnet_names_for_cdp}
plat__azure_subnet_names_for_gateway: ${plat__azure_subnet_names_for_gateway}

plat__azure_storage_location: ${plat__azure_storage_location}
plat__azure_log_location: ${plat__azure_log_location}
plat__azure_backup_location: ${plat__azure_backup_location}

plat__public_key_text: ${plat__public_key_text}
plat__azure_security_group_default_uri: ${plat__azure_security_group_default_uri}
plat__azure_security_group_knox_uri: ${plat__azure_security_group_knox_uri}

plat__azure_xaccount_app_uuid: ${plat__azure_xaccount_app_uuid}
plat__azure_xaccount_app_pword: ${plat__azure_xaccount_app_pword}

plat__azure_idbroker_identity_id: ${plat__azure_idbroker_identity_id}
plat__azure_datalakeadmin_identity_id: ${plat__azure_datalakeadmin_identity_id}
plat__azure_ranger_audit_identity_id: ${plat__azure_ranger_audit_identity_id}
plat__azure_log_identity_id: ${plat__azure_log_identity_id}
plat__azure_raz_identity_id: ${plat__azure_raz_identity_id}
