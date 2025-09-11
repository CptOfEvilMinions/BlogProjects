provider "aws" {
  region = var.primary_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.8.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.87.1"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "databricks-btv-dc30-state-8nxbn"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "databricks-btv-dc30-state-8nxbn"
    encrypt        = true
  }
}
