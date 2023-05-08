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
plat__enable_raz: ${plat__enable_raz}
plat__env_multiaz: ${plat__env_multiaz} 
plat__env_freeipa_instances: ${plat__env_freeipa_instances} 
plat__workload_analytics: ${plat__workload_analytics}
plat__tags: ${plat__tags}

# CDP settings
plat__cdp_profile: ${plat__cdp_profile}
plat__cdp_control_plane_region:  ${plat__cdp_control_plane_region}

# CSP settings
plat__infra_type: ${plat__infra_type} 
plat__region: ${plat__region}

plat__aws_vpc_id: ${plat__aws_vpc_id}
plat__aws_public_subnet_ids: ${plat__aws_public_subnet_ids}
plat__aws_private_subnet_ids: ${plat__aws_private_subnet_ids}
plat__aws_subnets_for_cdp: ${plat__aws_subnets_for_cdp}

plat__aws_storage_location: ${plat__aws_storage_location}
plat__aws_log_location: ${plat__aws_log_location}

plat__public_key_id: ${plat__public_key_id}
plat__aws_security_group_default_id: ${plat__aws_security_group_default_id}
plat__aws_security_group_knox_id: ${plat__aws_security_group_knox_id}

plat__aws_datalake_admin_role_arn: ${plat__aws_datalake_admin_role_arn}
plat__aws_ranger_audit_role_arn: ${plat__aws_ranger_audit_role_arn} 
plat__aws_xaccount_role_arn: ${plat__aws_xaccount_role_arn}  

plat__aws_log_instance_profile_arn: ${plat__aws_log_instance_profile_arn} 
plat__aws_idbroker_instance_profile_arn: ${plat__aws_idbroker_instance_profile_arn}
