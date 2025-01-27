# ------- CDP IDBroker Assume Role policy -------
resource "aws_iam_policy" "cdp_idbroker_policy" {
  name        = var.idbroker_policy_name
  description = "CDP IDBroker Assume Role policy"

  tags = merge(var.tags, { Name = var.idbroker_policy_name })

  policy = var.idbroker_policy_doc
}

# ------- CDP Data Access Policies - Log -------
resource "aws_iam_policy" "cdp_log_data_access_policy" {
  name        = var.log_data_access_policy_name
  description = "CDP Log Location Access policy"

  tags = merge(var.tags, { Name = var.log_data_access_policy_name })

  policy = local.log_data_access_policy_doc

}
# ------- CDP Data Access Policies - ranger_audit_s3 -------
resource "aws_iam_policy" "cdp_ranger_audit_s3_data_access_policy" {
  name        = var.ranger_audit_s3_policy_name
  description = "CDP Ranger Audit S3 Access policy"

  tags = merge(var.tags, { Name = var.ranger_audit_s3_policy_name })

  policy = local.ranger_audit_s3_policy_doc
}

# ------- CDP Data Access Policies - datalake_admin_s3 -------
resource "aws_iam_policy" "cdp_datalake_admin_s3_data_access_policy" {
  name        = var.datalake_admin_s3_policy_name
  description = "CDP Datalake Admin S3 Access policy"

  tags = merge(var.tags, { Name = var.datalake_admin_s3_policy_name })

  policy = local.datalake_admin_s3_policy_doc

}

# ------- CDP Data Access Policies - bucket_access -------
# Policy for Data bucket
resource "aws_iam_policy" "cdp_data_bucket_data_access_policy" {
  name        = var.data_bucket_access_policy_name
  description = "CDP Data Bucket S3 Access policy"

  tags = merge(var.tags, { Name = var.data_bucket_access_policy_name })

  policy = local.data_bucket_access_policy_doc
}

# Policy for Log bucket...Only required if log bucket different from data bucket
resource "aws_iam_policy" "cdp_log_bucket_data_access_policy" {
  name        = var.log_bucket_access_policy_name
  description = "CDP Log Bucket S3 Access policy"

  tags = merge(var.tags, { Name = var.log_bucket_access_policy_name })

  policy = local.log_bucket_access_policy_doc
}
# Policy for backup bucket...requied only if different from backup and log bucket
resource "aws_iam_policy" "cdp_backup_bucket_data_access_policy" {
  name        = var.backup_bucket_access_policy_name
  description = "CDP Backup Bucket S3 Access policy"

  tags = merge(var.tags, { Name = var.backup_bucket_access_policy_name })

  policy = local.backup_bucket_access_policy_doc
}

# ------- CDP Data Access Policies - datalake_backup_policy -------
resource "aws_iam_policy" "cdp_datalake_backup_policy" {
  name        = var.datalake_backup_policy_name
  description = "CDP Datalake Backup policy"

  tags = merge(var.tags, { Name = var.datalake_backup_policy_name })

  policy = local.datalake_backup_policy_doc
}

# ------- CDP Data Access Policies - datalake_restore_policy -------
resource "aws_iam_policy" "cdp_datalake_restore_policy" {
  name        = var.datalake_restore_policy_name
  description = "CDP Datalake Restore policy"

  tags = merge(var.tags, { Name = var.datalake_restore_policy_name })

  policy = local.datalake_restore_policy_doc
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
  name        = var.idbroker_role_name
  description = "CDP IDBroker role"

  assume_role_policy = data.aws_iam_policy_document.cdp_idbroker_role_policy_doc.json

  tags = merge(var.tags, { Name = var.idbroker_role_name })
}

# Create an instance profile for the iam_role
resource "aws_iam_instance_profile" "cdp_idbroker_role_instance_profile" {
  name = var.idbroker_role_name
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
  name        = var.log_role_name
  description = "CDP Log role"

  assume_role_policy = data.aws_iam_policy_document.cdp_log_role_policy_doc.json

  tags = merge(var.tags, { Name = var.log_role_name })
}

# Create an instance profile for the iam_role
resource "aws_iam_instance_profile" "cdp_log_role_instance_profile" {
  name = var.log_role_name
  role = aws_iam_role.cdp_log_role.name
}

# Attach AWS Log Location Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_log_role_attach1" {
  role       = aws_iam_role.cdp_log_role.name
  policy_arn = aws_iam_policy.cdp_log_data_access_policy.arn
}

# Attach AWS Datalake Backup Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_log_role_attach3" {
  role       = aws_iam_role.cdp_log_role.name
  policy_arn = aws_iam_policy.cdp_datalake_backup_policy.arn
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
  name        = var.datalake_admin_role_name
  description = "CDP Datalake Admin role"

  assume_role_policy = data.aws_iam_policy_document.cdp_datalake_admin_role_policy_doc.json

  tags = merge(var.tags, { Name = var.datalake_admin_role_name })
}

# Create an instance profile for the iam_role
resource "aws_iam_instance_profile" "cdp_datalake_admin_role_instance_profile" {
  name = var.datalake_admin_role_name
  role = aws_iam_role.cdp_datalake_admin_role.name
}

# Attach AWS Datalake Admin S3 Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_datalake_admin_role_attach1" {
  role       = aws_iam_role.cdp_datalake_admin_role.name
  policy_arn = aws_iam_policy.cdp_datalake_admin_s3_data_access_policy.arn
}

# Attach AWS Bucket Access Policy to the Role
# ..data bucket policy
resource "aws_iam_role_policy_attachment" "cdp_datalake_admin_role_attach2" {
  role       = aws_iam_role.cdp_datalake_admin_role.name
  policy_arn = aws_iam_policy.cdp_data_bucket_data_access_policy.arn
}

# ..log bucket policy, if required
resource "aws_iam_role_policy_attachment" "cdp_datalake_admin_role_attach3" {
  role       = aws_iam_role.cdp_datalake_admin_role.name
  policy_arn = aws_iam_policy.cdp_log_bucket_data_access_policy.arn
}

# ..backup bucket policy, if required
resource "aws_iam_role_policy_attachment" "cdp_datalake_admin_role_attach4" {
  role       = aws_iam_role.cdp_datalake_admin_role.name
  policy_arn = aws_iam_policy.cdp_backup_bucket_data_access_policy.arn
}

# Attach AWS Datalake Backup Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_datalake_admin_role_attach5" {
  role       = aws_iam_role.cdp_datalake_admin_role.name
  policy_arn = aws_iam_policy.cdp_datalake_backup_policy.arn
}

# Attach AWS Datalake Restore Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_datalake_admin_role_attach6" {
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
  name        = var.ranger_audit_role_name
  description = "CDP Ranger Audit role"

  assume_role_policy = data.aws_iam_policy_document.cdp_ranger_audit_role_policy_doc.json

  tags = merge(var.tags, { Name = var.ranger_audit_role_name })
}

# Create an instance profile for the iam_role
resource "aws_iam_instance_profile" "cdp_ranger_audit_role_instance_profile" {
  name = var.ranger_audit_role_name
  role = aws_iam_role.cdp_ranger_audit_role.name
}

# Attach AWS Ranger Audit S3 Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_ranger_audit_role_attach1" {
  role       = aws_iam_role.cdp_ranger_audit_role.name
  policy_arn = aws_iam_policy.cdp_ranger_audit_s3_data_access_policy.arn
}

# Attach AWS Bucket Access Policies to the Role
# ..data bucket policy
resource "aws_iam_role_policy_attachment" "cdp_ranger_audit_role_attach2" {
  role       = aws_iam_role.cdp_ranger_audit_role.name
  policy_arn = aws_iam_policy.cdp_data_bucket_data_access_policy.arn
}

# ..log bucket policy, if required
resource "aws_iam_role_policy_attachment" "cdp_ranger_audit_role_attach3" {
  role       = aws_iam_role.cdp_ranger_audit_role.name
  policy_arn = aws_iam_policy.cdp_log_bucket_data_access_policy.arn
}

# ..backup bucket policy, if required
resource "aws_iam_role_policy_attachment" "cdp_ranger_audit_role_attach4" {
  role       = aws_iam_role.cdp_ranger_audit_role.name
  policy_arn = aws_iam_policy.cdp_backup_bucket_data_access_policy.arn
}

# Attach AWS Datalake Backup Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_ranger_audit_role_attach5" {
  role       = aws_iam_role.cdp_ranger_audit_role.name
  policy_arn = aws_iam_policy.cdp_datalake_backup_policy.arn
}

# Attach AWS Datalake Restore Policy to the Role
resource "aws_iam_role_policy_attachment" "cdp_ranger_audit_role_attach6" {
  role       = aws_iam_role.cdp_ranger_audit_role.name
  policy_arn = aws_iam_policy.cdp_datalake_restore_policy.arn
}
