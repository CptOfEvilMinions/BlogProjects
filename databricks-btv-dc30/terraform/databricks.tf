resource "databricks_storage_credential" "btv_logs" {
  name = aws_iam_role.databricks.name

  aws_iam_role {
    role_arn = aws_iam_role.databricks.arn
  }
}

resource "databricks_external_location" "btv_logs_bronze" {
  name            = aws_s3_bucket.bronze.id
  url             = "s3://${aws_s3_bucket.bronze.id}/"
  credential_name = databricks_storage_credential.btv_logs.id
  comment         = "Managed by TF"
}

resource "databricks_external_location" "btv_logs_silver" {
  name            = aws_s3_bucket.silver.id
  url             = "s3://${aws_s3_bucket.silver.id}/"
  credential_name = databricks_storage_credential.btv_logs.id
}

resource "databricks_external_location" "btv_logs_gold" {
  name            = aws_s3_bucket.gold.id
  url             = "s3://${aws_s3_bucket.gold.id}/"
  credential_name = databricks_storage_credential.btv_logs.id
}

resource "databricks_catalog" "btv_logs" {
  name         = replace(var.project_prefix, "-", "_")
  comment      = "${var.project_prefix} catalog for logs"
  storage_root = databricks_external_location.btv_logs_silver.url
}

resource "databricks_schema" "btv_logs_bronze" {
  catalog_name = databricks_catalog.btv_logs.id
  name         = "bronze"
  comment      = "Access raw logs in S3"
}

resource "databricks_schema" "btv_logs_silver" {
  catalog_name = databricks_catalog.btv_logs.id
  name         = "silver"
  comment      = "Storage for parsed logs"
}

resource "databricks_schema" "btv_logs_gold" {
  catalog_name = databricks_catalog.btv_logs.id
  name         = "gold"
  comment      = "Storage for normalized logs to Splunk CIM"
}
