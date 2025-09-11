resource "random_string" "bucket_suffix" {
  length  = 5
  special = false
  upper   = false
}

# Create a KMS key
resource "aws_kms_key" "bronze" {
  description             = "KMS key for encrypting ${var.project_prefix} bronze S3 bucket"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_key" "silver" {
  description             = "KMS key for encrypting ${var.project_prefix} silver S3 buckets"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}


resource "aws_kms_key" "gold" {
  description             = "KMS key for encrypting ${var.project_prefix} gold S3 buckets"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}


resource "aws_s3_bucket" "bronze" {
  bucket = "${var.project_prefix}-bronze-${random_string.bucket_suffix.result}"
}

resource "aws_s3_bucket" "silver" {
  bucket = "${var.project_prefix}-silver-${random_string.bucket_suffix.result}"
}

resource "aws_s3_bucket" "gold" {
  bucket = "${var.project_prefix}-gold-${random_string.bucket_suffix.result}"
}


resource "aws_s3_bucket_server_side_encryption_configuration" "bronze" {
  bucket = aws_s3_bucket.bronze.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.bronze.arn
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "silver" {
  bucket = aws_s3_bucket.silver.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.silver.arn
    }
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "gold" {
  bucket = aws_s3_bucket.gold.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.gold.arn
    }
  }
}



resource "aws_s3_object" "upload_logs" {
  for_each = fileset("${path.module}/../logs/", "**/*.*")

  bucket = aws_s3_bucket.bronze.id
  key    = each.value
  source = "${path.module}/../logs/${each.value}"
  etag   = filemd5("${path.module}/../logs/${each.value}")
}
