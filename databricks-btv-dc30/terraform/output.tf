output "databricks_role_arn" {
  value       = aws_iam_role.databricks.arn
  description = "The ARN of the Databricks IAM role"
}

output "bronze_s3_bucket_arn" {
  value       = aws_s3_bucket.bronze.arn
  description = "The ARN of the bronze S3 bucket"
}

output "silver_s3_bucket_arn" {
  value       = aws_s3_bucket.silver.arn
  description = "The ARN of the silver S3 bucket"
}
