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

  # ------- Network Resources -------
  resourcegroup_name = coalesce(var.resourcegroup_name, "${var.env_prefix}-rmgp")

  vnet_name = coalesce(var.vnet_name, "${var.env_prefix}-net")


  # Calculate number of subnets based on the deployment_type
  subnets_required = {
    total   = (var.deployment_template == "public") ? var.subnet_count : 2 * var.subnet_count
    public  = var.subnet_count
    private = (var.deployment_template == "public") ? 0 : var.subnet_count
  }

  # Public Network infrastructure
  public_subnets = (local.subnets_required.public == 0 ?
    [] :
    [
      for idx in range(local.subnets_required.public) :
      {
        name = "${var.env_prefix}-sbnt-pub-${format("%02d", idx + 1)}"
        cidr = cidrsubnet(var.vnet_cidr, ceil(log(local.subnets_required.total, 2)), idx)
      }
  ])

  # Private Network infrastructure
  private_subnets = (local.subnets_required.private == 0 ?
    [] :
    [
      for idx in range(local.subnets_required.private) :
      {
        name = "${var.env_prefix}-sbnt-pvt-${format("%02d", idx + 1)}"
        cidr = cidrsubnet(var.vnet_cidr, ceil(log(local.subnets_required.total, 2)), local.subnets_required.public + idx)
      }
  ])

  # ------- Storage Resources -------
  storage_suffix = var.random_id_for_bucket ? "${one(random_id.bucket_suffix).hex}" : ""

  # Azure storage containers can only contain numbers and letters
  default_data_storage_name = "${replace(var.env_prefix, "/[-_]/", "")}stor"

  data_storage = {
    data_storage_bucket = try(var.data_storage.data_storage_bucket, local.default_data_storage_name)
    data_storage_object = try(var.data_storage.data_storage_object, "data")
  }
  log_storage = {
    log_storage_bucket = try(var.log_storage.log_storage_bucket, local.data_storage.data_storage_bucket)
    log_storage_object = try(var.log_storage.log_storage_object, "logs")
  }

  backup_storage = {
    backup_storage_bucket = try(var.backup_storage.backup_storage_bucket, local.data_storage.data_storage_bucket)
    backup_storage_object = try(var.backup_storage.backup_storage_object, "backups")
  }

}