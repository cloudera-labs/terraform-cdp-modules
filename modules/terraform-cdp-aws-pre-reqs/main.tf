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

# ------- VPC -------
# Create the VPC if required
module "aws_cdp_vpc" {

  source = "../terraform-aws-vpc"

  create_vpc = var.create_vpc

  deployment_template        = var.deployment_template
  vpc_name                   = local.vpc_name
  vpc_cidr                   = var.vpc_cidr
  private_network_extensions = var.private_network_extensions

  tags = local.env_tags

  private_cidr_range = var.private_cidr_range
  public_cidr_range  = var.public_cidr_range

  vpc_public_subnets_map_public_ip_on_launch = var.vpc_public_subnets_map_public_ip_on_launch

  vpc_public_inbound_acl_rules   = var.vpc_public_inbound_acl_rules
  vpc_public_outbound_acl_rules  = var.vpc_public_outbound_acl_rules
  vpc_private_inbound_acl_rules  = var.vpc_private_inbound_acl_rules
  vpc_private_outbound_acl_rules = var.vpc_private_outbound_acl_rules

  existing_vpc_id             = var.cdp_vpc_id
  existing_public_subnet_ids  = var.cdp_public_subnet_ids
  existing_private_subnet_ids = var.cdp_private_subnet_ids
}

# ------- Security Groups -------
# Default SG
resource "aws_security_group" "cdp_default_sg" {
  vpc_id      = module.aws_cdp_vpc.vpc_id
  name        = local.security_group_default_name
  description = local.security_group_default_name
  tags        = merge(local.env_tags, { Name = local.security_group_default_name })
}

# Create self reference ingress rule to allow communication within the security group
resource "aws_security_group_rule" "cdp_default_sg_ingress_self" {
  security_group_id = aws_security_group.cdp_default_sg.id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  description       = "Self-reference ingress rule"
  protocol          = "all"
  self              = true
}

# Create security group rules from combining the default and extra list of ingress rules
resource "aws_security_group_rule" "cdp_default_sg_ingress" {
  count = length(concat(local.security_group_rules_ingress, local.security_group_rules_extra_ingress))

  description       = "Ingress rules for Default CDP Security Group"
  security_group_id = aws_security_group.cdp_default_sg.id
  type              = "ingress"
  cidr_blocks       = tolist(concat(local.security_group_rules_ingress, local.security_group_rules_extra_ingress))[count.index].cidr
  from_port         = tolist(concat(local.security_group_rules_ingress, local.security_group_rules_extra_ingress))[count.index].port
  to_port           = tolist(concat(local.security_group_rules_ingress, local.security_group_rules_extra_ingress))[count.index].port
  protocol          = tolist(concat(local.security_group_rules_ingress, local.security_group_rules_extra_ingress))[count.index].protocol
}

# Terraform removes the default ALLOW ALL egress. Let's recreate this
resource "aws_security_group_rule" "cdp_default_sg_egress" {

  description       = "Egress rule for Default CDP Security Group"
  security_group_id = aws_security_group.cdp_default_sg.id
  type              = "egress"
  cidr_blocks       = var.cdp_default_sg_egress_cidrs #tfsec:ignore:aws-ec2-no-public-egress-sgr #tfsec:ignore:aws-vpc-no-public-egress-sgr
  from_port         = 0
  to_port           = 0
  protocol          = "all"
}

# Knox SG
resource "aws_security_group" "cdp_knox_sg" {
  vpc_id      = module.aws_cdp_vpc.vpc_id
  name        = local.security_group_knox_name
  description = local.security_group_knox_name
  tags        = merge(local.env_tags, { Name = local.security_group_knox_name })
}

# Create self reference ingress rule to allow communication within the security group.
resource "aws_security_group_rule" "cdp_knox_sg_ingress_self" {
  security_group_id = aws_security_group.cdp_knox_sg.id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  description       = "Self-reference ingress rule"
  protocol          = "all"
  self              = true
}

# Create security group rules from combining the default and extra list of ingress rules
resource "aws_security_group_rule" "cdp_knox_sg_ingress" {
  count = length(concat(local.security_group_rules_ingress, local.security_group_rules_extra_ingress))

  description       = "Ingress rule for Knox CDP Security Group"
  security_group_id = aws_security_group.cdp_knox_sg.id
  type              = "ingress"
  cidr_blocks       = tolist(concat(local.security_group_rules_ingress, local.security_group_rules_extra_ingress))[count.index].cidr
  from_port         = tolist(concat(local.security_group_rules_ingress, local.security_group_rules_extra_ingress))[count.index].port
  to_port           = tolist(concat(local.security_group_rules_ingress, local.security_group_rules_extra_ingress))[count.index].port
  protocol          = tolist(concat(local.security_group_rules_ingress, local.security_group_rules_extra_ingress))[count.index].protocol
}

# Terraform removes the default ALLOW ALL egress. Let's recreate this
resource "aws_security_group_rule" "cdp_knox_sg_egress" {

  description       = "Egress rule for Knox CDP Security Group"
  security_group_id = aws_security_group.cdp_knox_sg.id
  type              = "egress"
  cidr_blocks       = var.cdp_knox_sg_egress_cidrs #tfsec:ignore:aws-ec2-no-public-egress-sgr #tfsec:ignore:aws-vpc-no-public-egress-sgr
  from_port         = 0
  to_port           = 0
  protocol          = "all"
}

# VPC Endpoint SG
resource "aws_security_group" "cdp_endpoint_sg" {

  count = (var.create_vpc && var.create_vpc_endpoints) ? 1 : 0

  vpc_id      = module.aws_cdp_vpc.vpc_id
  name        = local.security_group_endpoint_name
  description = local.security_group_endpoint_name
  tags        = merge(local.env_tags, { Name = local.security_group_endpoint_name })
}

# Create self reference ingress rule to allow communication within the security group
resource "aws_security_group_rule" "cdp_endpoint_ingress_self" {

  count = (var.create_vpc && var.create_vpc_endpoints) ? 1 : 0

  security_group_id = aws_security_group.cdp_endpoint_sg[0].id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  description       = "Self-reference ingress rule"
  protocol          = "all"
  self              = true
}

# Create security group rules from combining the default and extra list of ingress rules
resource "aws_security_group_rule" "cdp_endpoint_sg_ingress" {
  count = (var.create_vpc && var.create_vpc_endpoints) ? length(local.security_group_rules_ingress) : 0

  description       = "Ingress rules for Endpoint Security Group"
  security_group_id = aws_security_group.cdp_endpoint_sg[0].id
  type              = "ingress"
  cidr_blocks       = tolist(local.security_group_rules_ingress)[count.index].cidr
  from_port         = tolist(local.security_group_rules_ingress)[count.index].port
  to_port           = tolist(local.security_group_rules_ingress)[count.index].port
  protocol          = tolist(local.security_group_rules_ingress)[count.index].protocol
}

# Terraform removes the default ALLOW ALL egress. Let's recreate this
resource "aws_security_group_rule" "cdp_endpoint_sg_egress" {

  count = (var.create_vpc && var.create_vpc_endpoints) ? 1 : 0

  description       = "Egress rule for Endpoint CDP Security Group"
  security_group_id = aws_security_group.cdp_endpoint_sg[0].id
  type              = "egress"
  cidr_blocks       = var.cdp_endpoint_sg_egress_cidrs #tfsec:ignore:aws-ec2-no-public-egress-sgr #tfsec:ignore:aws-vpc-no-public-egress-sgr
  from_port         = 0
  to_port           = 0
  protocol          = "all"
}

# ------- VPC Endpoints -------
# S3 Gateway endpoint
resource "aws_vpc_endpoint" "gateway_endpoints" {

  for_each = {
    for k, v in toset(var.vpc_endpoint_gateway_services) : k => v
    if var.create_vpc && var.create_vpc_endpoints
  }

  vpc_id            = module.aws_cdp_vpc.vpc_id
  service_name      = data.aws_vpc_endpoint_service.gateway_endpoints[each.key].service_name
  vpc_endpoint_type = "Gateway"
  route_table_ids   = concat([module.aws_cdp_vpc.default_route_table], module.aws_cdp_vpc.public_route_tables, module.aws_cdp_vpc.private_route_tables)

  tags = merge(local.env_tags, { Name = "${var.env_prefix}-${each.key}-gateway-endpoint" })
}

# Interface endpoints
# From list in vpc_endpoint_interface_services
resource "aws_vpc_endpoint" "interface_endpoints" {

  for_each = {
    for k, v in toset(var.vpc_endpoint_interface_services) : k => v
    if var.create_vpc && var.create_vpc_endpoints
  }

  vpc_id              = module.aws_cdp_vpc.vpc_id
  service_name        = data.aws_vpc_endpoint_service.interface_endpoints[each.key].service_name
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = var.deployment_template == "public" ? module.aws_cdp_vpc.public_subnets : module.aws_cdp_vpc.private_subnets
  security_group_ids = [aws_security_group.cdp_endpoint_sg[0].id]

  tags = merge(local.env_tags, { Name = "${var.env_prefix}-${each.key}-interface-endpoint" })
}

# ------- S3 Buckets -------
resource "random_id" "bucket_suffix" {
  count = var.random_id_for_bucket ? 1 : 0

  byte_length = 4
}

resource "aws_s3_bucket" "cdp_storage_locations" {
  # Create buckets for the unique list of buckets in data and log storage
  for_each = toset(concat([local.data_storage.data_storage_bucket], [local.log_storage.log_storage_bucket], [local.backup_storage.backup_storage_bucket]))

  bucket = "${each.value}${local.storage_suffix}"
  tags   = merge(local.env_tags, { Name = "${each.value}${local.storage_suffix}" })

  # Purge storage locations during teardown?
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "cdp_storage_locations" {

  for_each = aws_s3_bucket.cdp_storage_locations

  bucket = each.value.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_kms_key" "cdp_kms_key" {

  count = var.enable_kms_bucket_encryption ? 1 : 0

  description         = "KMS key for Bucket Encryption of ${var.env_prefix} CDP environment"
  enable_key_rotation = "true"
}

resource "aws_kms_alias" "cdp_kms_alias" {

  count = var.enable_kms_bucket_encryption ? 1 : 0

  name          = "alias/${var.env_prefix}"
  target_key_id = aws_kms_key.cdp_kms_key[0].key_id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cdp_storage_location_kms" {

  for_each = var.enable_kms_bucket_encryption ? aws_s3_bucket.cdp_storage_locations : {}

  bucket = each.value.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.cdp_kms_key[0].arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "cdp_storage_location_versioning" {

  for_each = var.enable_bucket_versioning ? aws_s3_bucket.cdp_storage_locations : {}

  bucket = each.value.id

  versioning_configuration {
    status = "Enabled"
  }

}

# ------- AWS Buckets directory structures -------
# # Data Storage Objects
# NOTE: Removing creation of the data storage object because CDP overrides this
# resource "aws_s3_object" "cdp_data_storage_object" {

#   bucket = "${local.data_storage.data_storage_bucket}${local.storage_suffix}"

#   key          = local.data_storage.data_storage_object
#   content_type = "application/x-directory"

#   depends_on = [
#     aws_s3_bucket.cdp_storage_locations
#   ]
# }

# Log Storage Objects
resource "aws_s3_object" "cdp_log_storage_object" {

  bucket = "${local.log_storage.log_storage_bucket}${local.storage_suffix}"

  key          = local.log_storage.log_storage_object
  content_type = "application/x-directory"

  depends_on = [
    aws_s3_bucket.cdp_storage_locations
  ]
}

# Backup Storage Object
resource "aws_s3_object" "cdp_backup_storage_object" {

  bucket = "${local.backup_storage.backup_storage_bucket}${local.storage_suffix}"

  key          = local.backup_storage.backup_storage_object
  content_type = "application/x-directory"

  depends_on = [
    aws_s3_bucket.cdp_storage_locations
  ]
}

# ------- Credential Permissions - Cross Account Role -------
module "aws_cdp_cred_permissions" {

  source = "../terraform-aws-cred-permissions"

  xaccount_role_name   = local.xaccount_role_name
  xaccount_account_id  = var.xaccount_account_id
  xaccount_external_id = var.xaccount_external_id

  xaccount_policy_name          = local.xaccount_policy_name
  xaccount_account_policy_doc   = var.xaccount_account_policy_doc
  create_cml_assume_role_policy = var.xaccount_cml_backup_assume_role

  existing_xaccount_role_name = var.existing_xaccount_role_name

  tags = local.env_tags

}

# ------- Permissions -------
module "aws_cdp_permissions" {

  source = "../terraform-aws-permissions"

  tags = local.env_tags

  idbroker_policy_name = local.idbroker_policy_name
  idbroker_policy_doc  = var.idbroker_policy_doc

  log_data_access_policy_name = local.log_data_access_policy_name
  log_data_access_policy_doc  = var.log_data_access_policy_doc

  ranger_audit_s3_policy_name = local.ranger_audit_s3_policy_name
  ranger_audit_s3_policy_doc  = var.ranger_audit_s3_policy_doc

  datalake_admin_s3_policy_name = local.datalake_admin_s3_policy_name
  datalake_admin_s3_policy_doc  = var.datalake_admin_s3_policy_doc

  data_bucket_access_policy_name   = local.data_bucket_access_policy_name
  data_bucket_access_policy_doc    = var.data_bucket_access_policy_doc
  log_bucket_access_policy_name    = local.log_bucket_access_policy_name
  log_bucket_access_policy_doc     = var.log_bucket_access_policy_doc
  backup_bucket_access_policy_name = local.backup_bucket_access_policy_name
  backup_bucket_access_policy_doc  = var.backup_bucket_access_policy_doc

  data_storage_bucket   = "${local.data_storage.data_storage_bucket}${local.storage_suffix}"
  log_storage_bucket    = "${local.log_storage.log_storage_bucket}${local.storage_suffix}"
  backup_storage_bucket = "${local.backup_storage.backup_storage_bucket}${local.storage_suffix}"

  storage_location_base = "${local.data_storage.data_storage_bucket}${local.storage_suffix}/${replace(local.data_storage.data_storage_object, "/", "")}"
  log_location_base     = "${local.log_storage.log_storage_bucket}${local.storage_suffix}/${replace(local.log_storage.log_storage_object, "/", "")}"
  backup_location_base  = "${local.backup_storage.backup_storage_bucket}${local.storage_suffix}/${replace(local.backup_storage.backup_storage_object, "/", "")}"

  datalake_backup_policy_name  = local.datalake_backup_policy_name
  datalake_backup_policy_doc   = var.datalake_backup_policy_doc
  datalake_restore_policy_name = local.datalake_restore_policy_name
  datalake_restore_policy_doc  = var.datalake_restore_policy_doc

  idbroker_role_name       = local.idbroker_role_name
  log_role_name            = local.log_role_name
  datalake_admin_role_name = local.datalake_admin_role_name
  ranger_audit_role_name   = local.ranger_audit_role_name

  depends_on = [aws_s3_bucket.cdp_storage_locations]
}
