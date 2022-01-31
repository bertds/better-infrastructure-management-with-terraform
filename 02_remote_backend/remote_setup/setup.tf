# This code is only required if you want to setup your own terraform state S3 bucket and DynamoDB locking table
terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.46.0"
    }
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "academy"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "better-infrastructure-management-with-terraform-${random_integer.student_id.result}"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "app-state-${random_integer.student_id.result}"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  // TO DO: complete this resource block!
}

resource "random_integer" "student_id" {
  min = 0
  max = 255
}
