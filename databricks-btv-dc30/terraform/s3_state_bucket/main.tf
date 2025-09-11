provider "aws" {
  region = "us-west-2"
}

resource "random_string" "bucket_suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  # Enable versioning so we can see the full revision history of our
  # state files
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  # Enable server-side encryption by default
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "databricks-btv-dc30-state-${random_string.bucket_suffix.result}"
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "databricks-btv-dc30-state-${random_string.bucket_suffix.result}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
