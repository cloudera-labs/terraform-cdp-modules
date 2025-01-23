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

# ------- Cross Account Policy -------
# Create assume role policy document for the Cross Account
data "aws_iam_policy_document" "cdp_xaccount_role_policy_doc" {

  count = local.create_xaccount_resources ? 1 : 0

  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.xaccount_account_id}:root"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [var.xaccount_external_id]
    }
  }
}
# Optional assume role policy document for the CML Backup and Restore
data "aws_iam_policy_document" "cml_backup_assume_policy_doc" {

  count = (local.create_xaccount_resources && var.create_cml_assume_role_policy) ? 1 : 0

  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "cdp_xaccount_assume_role_policy" {
  count = local.create_xaccount_resources ? 1 : 0

  source_policy_documents = [
    data.aws_iam_policy_document.cdp_xaccount_role_policy_doc[0].json,
    try(data.aws_iam_policy_document.cml_backup_assume_policy_doc[0].json, "")
  ]
}

# Create the IAM role that uses the above assume_role_policy document
resource "aws_iam_role" "cdp_xaccount_role" {

  count = local.create_xaccount_resources ? 1 : 0

  name        = var.xaccount_role_name
  description = "CDP Cross Account role"

  assume_role_policy = data.aws_iam_policy_document.cdp_xaccount_assume_role_policy[0].json

  tags = merge(var.tags, { Name = var.xaccount_role_name })
}

# Create AWS Cross Account Inline Policy
resource "aws_iam_role_policy" "cdp_xaccount_policy" {

  count = local.create_xaccount_resources ? 1 : 0

  name = var.xaccount_policy_name
  role = aws_iam_role.cdp_xaccount_role[0].id

  policy = var.xaccount_account_policy_doc
}

# Wait for propagation of IAM xaccount role.
# Required for CDP credential
resource "time_sleep" "iam_propagation" {
  depends_on      = [aws_iam_role.cdp_xaccount_role]
  create_duration = "45s"
}
