data "aws_caller_identity" "current" {}

data "databricks_storage_credential" "btv_logs" {
  name = databricks_storage_credential.btv_logs.name
}

data "aws_iam_policy_document" "databricks_assume" {

  # https://docs.databricks.com/aws/en/connect/unity-catalog/cloud-storage/storage-credentials#step-1-create-an-iam-role
  statement {
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.project_prefix}-databricks"
      ]
    }

    actions = ["sts:AssumeRole"]

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.databricks_external_id]
    }
  }
}

resource "aws_iam_role" "databricks" {
  name               = "${var.project_prefix}-databricks"
  assume_role_policy = data.aws_iam_policy_document.databricks_assume.json
}

resource "aws_iam_role_policy_attachment" "databricks" {
  role       = aws_iam_role.databricks.name
  policy_arn = aws_iam_policy.databricks.arn
}

resource "aws_iam_policy" "databricks" {
  name        = "${var.project_prefix}-databricks-policy"
  description = "${var.project_prefix} policy for Databricks"
  policy      = data.aws_iam_policy_document.databricks.json
}


data "aws_iam_policy_document" "databricks" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload"
    ]

    resources = [
      aws_s3_bucket.bronze.arn,
      aws_s3_bucket.silver.arn,
      aws_s3_bucket.gold.arn,
      "${aws_s3_bucket.bronze.arn}/*",
      "${aws_s3_bucket.silver.arn}/*",
      "${aws_s3_bucket.gold.arn}/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey*"
    ]

    resources = [
      aws_kms_key.bronze.arn,
      aws_kms_key.silver.arn,
      aws_kms_key.gold.arn,
    ]
  }

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.databricks.name}"
    ]
  }
}
