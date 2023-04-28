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
# Create the VPC if required
module "aws_cdp_vpc" {

  count = var.create_vpc ? 1 : 0

  source = "./modules/vpc"

  deployment_template = var.deployment_template
  vpc_cidr            = var.vpc_cidr
  env_prefix          = var.env_prefix
  tags                = local.env_tags

}

# ------- Security Groups -------
# Default SG
resource "aws_security_group" "cdp_default_sg" {
  vpc_id      = local.vpc_id
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
  cidr_blocks       = var.cdp_default_sg_egress_cidrs
  from_port         = 0
  to_port           = 0
  protocol          = "all"
}

# Knox SG
resource "aws_security_group" "cdp_knox_sg" {
  vpc_id      = local.vpc_id
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
  cidr_blocks       = var.cdp_knox_sg_egress_cidrs
  from_port         = 0
  to_port           = 0
  protocol          = "all"
}

# ------- S3 Buckets -------
resource "random_id" "bucket_suffix" {
  count = var.random_id_for_bucket ? 1 : 0

  byte_length = 4
}

resource "aws_s3_bucket" "cdp_storage_locations" {
  # Create buckets for the unique list of buckets in data and log storage
  for_each = toset(concat([local.data_storage.data_storage_bucket], [local.log_storage.log_storage_bucket]))

  bucket = "${each.value}${local.storage_suffix}"
  tags   = merge(local.env_tags, { Name = "${each.value}${local.storage_suffix}" })

  # Purge storage locations during teardown?
  force_destroy = true
}

# ------- AWS Buckets directory structures -------
# Data Storage Objects
resource "aws_s3_object" "cdp_data_storage_object" {

  for_each = toset(local.data_storage.data_storage_objects)

  bucket = var.random_id_for_bucket ? "${local.data_storage.data_storage_bucket}-${one(random_id.bucket_suffix).hex}" : local.data_storage.data_storage_bucket

  key          = each.key
  content_type = "application/x-directory"

  depends_on = [
    aws_s3_bucket.cdp_storage_locations
  ]
}

# Log Storage Objects
resource "aws_s3_object" "cdp_log_storage_object" {

  bucket = var.random_id_for_bucket ? "${local.log_storage.log_storage_bucket}-${one(random_id.bucket_suffix).hex}" : local.log_storage.log_storage_bucket

  key          = local.log_storage.log_storage_object
  content_type = "application/x-directory"

  depends_on = [
    aws_s3_bucket.cdp_storage_locations
  ]
}

# Backup Storage Object
resource "aws_s3_object" "cdp_backup_storage_object" {

  bucket = var.random_id_for_bucket ? "${local.backup_storage.backup_storage_bucket}-${one(random_id.bucket_suffix).hex}" : local.backup_storage.backup_storage_bucket

  key          = local.backup_storage.backup_storage_object
  content_type = "application/x-directory"

  depends_on = [
    aws_s3_bucket.cdp_storage_locations
  ]
}

# ------- AWS Cross Account Policy -------
# The policy here is a dict variable so we'll use the variable
# directly in the aws_iam_policy resource.
resource "aws_iam_policy" "cdp_xaccount_policy" {
  name        = local.xaccount_policy_name
  description = "CDP Cross Account policy for ${var.env_prefix}"

  tags = merge(local.env_tags, { Name = local.xaccount_policy_name })

  policy = local.xaccount_account_policy_doc
}

# ------- CDP IDBroker Assume Role policy -------
# First create the assume role policy document
data "aws_iam_policy_document" "cdp_idbroker_policy_doc" {
  version = "2012-10-17"

  statement {
    sid       = "VisualEditor0"
    actions   = ["sts:AssumeRole"]
    effect    = "Allow"
    resources = ["*"]
  }
}

# Then create the policy using the document
resource "aws_iam_policy" "cdp_idbroker_policy" {
  name        = local.idbroker_policy_name
  description = "CDP IDBroker Assume Role policy for ${var.env_prefix}"

  tags = merge(local.env_tags, { Name = local.idbroker_policy_name })

  policy = data.aws_iam_policy_document.cdp_idbroker_policy_doc.json
}

# ------- CDP Data Access Policies - Log -------
resource "aws_iam_policy" "cdp_log_data_access_policy" {
  name        = local.log_data_access_policy_name
  description = "CDP Log Location Access policy for ${var.env_prefix}"

  tags = merge(local.env_tags, { Name = local.log_data_access_policy_name })

  policy = local.log_data_access_policy_doc

}

# ------- CDP Data Access Policies - ranger_audit_s3 -------
resource "aws_iam_policy" "cdp_ranger_audit_s3_data_access_policy" {
  name        = local.ranger_audit_s3_policy_name
  description = "CDP Ranger Audit S3 Access policy for ${var.env_prefix}"

  tags = merge(local.env_tags, { Name = local.ranger_audit_s3_policy_name })

  policy = local.ranger_audit_s3_policy_doc
}

# ------- CDP Data Access Policies - datalake_admin_s3 -------
resource "aws_iam_policy" "cdp_datalake_admin_s3_data_access_policy" {
  name        = local.datalake_admin_s3_policy_name
  description = "CDP Datalake Admin S3 Access policy for ${var.env_prefix}"

  tags = merge(local.env_tags, { Name = local.datalake_admin_s3_policy_name })

  policy = local.datalake_admin_s3_policy_doc

}

# ------- CDP Data Access Policies - bucket_access -------
resource "aws_iam_policy" "cdp_bucket_data_access_policy" {
  name        = local.bucket_access_policy_name
  description = "CDP Bucket S3 Access policy for ${var.env_prefix}"

  tags = merge(local.env_tags, { Name = local.bucket_access_policy_name })

  policy = local.bucket_access_policy_doc
}

# ------- CDP Data Access Policies - datalake_backup_policy -------
resource "aws_iam_policy" "cdp_datalake_backup_policy" {
  name        = local.datalake_backup_policy_name
  description = "CDP Datalake Backup policy for ${var.env_prefix}"

  tags = merge(local.env_tags, { Name = local.datalake_backup_policy_name })

  policy = local.datalake_backup_policy_doc
}

# ------- CDP Data Access Policies - datalake_restore_policy -------
resource "aws_iam_policy" "cdp_datalake_restore_policy" {
  name        = local.datalake_restore_policy_name
  description = "CDP Datalake Restore policy for ${var.env_prefix}"

  tags = merge(local.env_tags, { Name = local.datalake_restore_policy_name })

  policy = local.datalake_restore_policy_doc
}

# ------- Cross Account Role -------
# First create the assume role policy document
data "aws_iam_policy_document" "cdp_xaccount_role_policy_doc" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.xaccount_account_id}:root"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [local.xaccount_external_id]
    }
  }
}

# Create the IAM role that uses the above assume_role_policy document
resource "aws_iam_role" "cdp_xaccount_role" {
  name        = local.xaccount_role_name
  description = "CDP Cross Account role for ${var.env_prefix}"

  assume_role_policy = data.aws_iam_policy_document.cdp_xaccount_role_policy_doc.json

  tags = merge(local.env_tags, { Name = local.xaccount_role_name })
}

# Attach AWS Cross Account Policy to Cross Account Role
resource "aws_iam_role_policy_attachment" "cdp_xaccount_role_attach" {
  role       = aws_iam_role.cdp_xaccount_role.name
  policy_arn = aws_iam_policy.cdp_xaccount_policy.arn
}

# ------- AWS Service Roles - CDP IDBroker -------
# First create the Assume role policy document
data "aws_iam_policy_document" "cdp_idbroker_role_policy_doc" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Create the IAM role that uses the above assume_role_policy document
resource "aws_iam_role" "cdp_idbroker_role" {
  name        = local.idbroker_role_name
  description = "CDP IDBroker role for ${var.env_prefix}"

  assume_role_policy = data.aws_iam_policy_document.cdp_idbroker_role_policy_doc.json

  tags = merge(local.env_tags, { Name = local.idbroker_role_name })
}

# Create an instance profile for the iam_role
resource "aws_iam_instance_profile" "cdp_idbroker_role_instance_profile" {
  name = local.idbroker_role_name
  role = aws_iam_role.cdp_idbroker_role.name
}

# Attach CDP IDBroker Assume Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_idbroker_role_attach1" {
  role       = aws_iam_role.cdp_idbroker_role.name
  policy_arn = aws_iam_policy.cdp_idbroker_policy.arn
}

# Attach AWS Log Location Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_idbroker_role_attach2" {

  role       = aws_iam_role.cdp_idbroker_role.name
  policy_arn = aws_iam_policy.cdp_log_data_access_policy.arn
}

# ------- AWS Service Roles - CDP Log -------
# First create the Assume role policy document
data "aws_iam_policy_document" "cdp_log_role_policy_doc" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Create the IAM role that uses the above assume_role_policy document
resource "aws_iam_role" "cdp_log_role" {
  name        = local.log_role_name
  description = "CDP Log role for ${var.env_prefix}"

  assume_role_policy = data.aws_iam_policy_document.cdp_log_role_policy_doc.json

  tags = merge(local.env_tags, { Name = local.log_role_name })
}

# Create an instance profile for the iam_role
resource "aws_iam_instance_profile" "cdp_log_role_instance_profile" {
  name = local.log_role_name
  role = aws_iam_role.cdp_log_role.name
}

# Attach AWS Log Location Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_log_role_attach1" {

  role       = aws_iam_role.cdp_log_role.name
  policy_arn = aws_iam_policy.cdp_log_data_access_policy.arn
}

# Attach AWS Bucket Access Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_log_role_attach2" {

  role       = aws_iam_role.cdp_log_role.name
  policy_arn = aws_iam_policy.cdp_bucket_data_access_policy.arn
}

# Attach AWS Datalake Restore Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_log_role_attach3" {

  role       = aws_iam_role.cdp_log_role.name
  policy_arn = aws_iam_policy.cdp_datalake_restore_policy.arn
}

# ------- AWS Data Access Roles - CDP Datalake Admin -------
# First create the Assume role policy document
data "aws_iam_policy_document" "cdp_datalake_admin_role_policy_doc" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.caller_account_id}:role/${aws_iam_role.cdp_idbroker_role.name}"]
    }
  }
}

# Create the IAM role that uses the above assume_role_policy document
resource "aws_iam_role" "cdp_datalake_admin_role" {
  name        = local.datalake_admin_role_name
  description = "CDP Datalake Admin role for ${var.env_prefix}"

  assume_role_policy = data.aws_iam_policy_document.cdp_datalake_admin_role_policy_doc.json

  tags = merge(local.env_tags, { Name = local.datalake_admin_role_name })
}

# Create an instance profile for the iam_role
resource "aws_iam_instance_profile" "cdp_datalake_admin_role_instance_profile" {
  name = local.datalake_admin_role_name
  role = aws_iam_role.cdp_datalake_admin_role.name
}

# Attach AWS Datalake Admin S3 Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_datalake_admin_role_attach1" {

  role       = aws_iam_role.cdp_datalake_admin_role.name
  policy_arn = aws_iam_policy.cdp_datalake_admin_s3_data_access_policy.arn
}

# Attach AWS Bucket Access Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_datalake_admin_role_attach2" {

  role       = aws_iam_role.cdp_datalake_admin_role.name
  policy_arn = aws_iam_policy.cdp_bucket_data_access_policy.arn
}

# Attach AWS Datalake Backup Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_datalake_admin_role_attach3" {

  role       = aws_iam_role.cdp_datalake_admin_role.name
  policy_arn = aws_iam_policy.cdp_datalake_backup_policy.arn
}

# Attach AWS Datalake Restore Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_datalake_admin_role_attach4" {

  role       = aws_iam_role.cdp_datalake_admin_role.name
  policy_arn = aws_iam_policy.cdp_datalake_restore_policy.arn
}

# ------- AWS Data Access Roles - CDP Ranger Audit -------
# First create the Assume role policy document
data "aws_iam_policy_document" "cdp_ranger_audit_role_policy_doc" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.caller_account_id}:role/${aws_iam_role.cdp_idbroker_role.name}"]
    }
  }
}

# Create the IAM role that uses the above assume_role_policy document
resource "aws_iam_role" "cdp_ranger_audit_role" {
  name        = local.ranger_audit_role_name
  description = "CDP Ranger Audit role for ${var.env_prefix}"

  assume_role_policy = data.aws_iam_policy_document.cdp_ranger_audit_role_policy_doc.json

  tags = merge(local.env_tags, { Name = local.ranger_audit_role_name })
}

# Create an instance profile for the iam_role
resource "aws_iam_instance_profile" "cdp_ranger_audit_role_instance_profile" {
  name = local.ranger_audit_role_name
  role = aws_iam_role.cdp_ranger_audit_role.name
}

# Attach AWS Ranger Audit S3 Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_ranger_audit_role_attach1" {

  role       = aws_iam_role.cdp_ranger_audit_role.name
  policy_arn = aws_iam_policy.cdp_ranger_audit_s3_data_access_policy.arn
}

# Attach AWS Bucket Access Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_ranger_audit_role_attach2" {

  role       = aws_iam_role.cdp_ranger_audit_role.name
  policy_arn = aws_iam_policy.cdp_bucket_data_access_policy.arn
}

# Attach AWS Datalake Backup Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_ranger_audit_role_attach3" {

  role       = aws_iam_role.cdp_ranger_audit_role.name
  policy_arn = aws_iam_policy.cdp_datalake_backup_policy.arn
}

# Attach AWS Datalake Restore Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_ranger_audit_role_attach4" {

  role       = aws_iam_role.cdp_ranger_audit_role.name
  policy_arn = aws_iam_policy.cdp_datalake_restore_policy.arn
}
