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

locals {
  # ------- Global settings -------
  env_tags = merge(var.agent_source_tag, (
    coalesce(var.env_tags,
      { env_prefix = var.env_prefix }
    ))
  )

  # ------- CDP Environment Deployment -------
  environment_name = coalesce(var.environment_name,
  "${var.env_prefix}-cdp-env")

  datalake_name = coalesce(var.datalake_name,
  "${var.env_prefix}-${local.cloud_shorthand[var.infra_type]}-dl")

  cdp_xacccount_credential_name = coalesce(var.cdp_xacccount_credential_name,
  "${var.env_prefix}-xaccount-cred")

  cdp_admin_group_name = coalesce(var.cdp_admin_group_name,
  "${var.env_prefix}-${local.cloud_shorthand[var.infra_type]}-cdp-admin-group")

  cdp_user_group_name = coalesce(var.cdp_user_group_name,
  "${var.env_prefix}-${local.cloud_shorthand[var.infra_type]}-cdp-user-group")

  datalake_scale = coalesce(
    var.datalake_scale,
    (var.deployment_template == "public" ?
      "LIGHT_DUTY" : "ENTERPRISE"
    )
  )

  endpoint_access_scheme = coalesce(
    var.endpoint_access_scheme,
    (var.deployment_template == "semi-private") ? "PUBLIC" : "PRIVATE"
  )

  # ------- Cloud Provider Settings - General -------
  cloud_shorthand = {
    azure = "az"
    aws   = "aw"
    gcp   = "gc"
  }

  # ------- Cloud Service Provider Settings - AWS specific -------
  aws_subnets_for_cdp = (
  var.infra_type == "aws" && var.deployment_template == "public") ? (concat(var.aws_public_subnet_ids, var.aws_private_subnet_ids)) : (var.aws_private_subnet_ids)

  # ------- Cloud Service Provider Settings - Azure specific -------
  use_public_ips = coalesce(
    var.use_public_ips,
    (var.deployment_template == "public")
  )

}
