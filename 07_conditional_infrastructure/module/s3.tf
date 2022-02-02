resource "aws_s3_bucket" "environment_bucket" {
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.s3_key.arn
        sse_algorithm     = (var.environment == "dev" ? "AES256" : "aws:kms")
      }
    }
  }
  versioning {
    enabled = (var.environment == "dev" ? false : true)
  }
}

resource "aws_s3_bucket_policy" "environment_bucket_policy" {
  bucket = aws_s3_bucket.environment_bucket.id


  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid    = "VPCDenyPut"
        Effect = (var.environment == "dev" ? "Allow" : "Deny")
        Principal = {
          "AWS" : "*"
        }
        Action = [
          "s3:PutObject"
        ]
        Resource = [
          aws_s3_bucket.environment_bucket.arn,
          "${aws_s3_bucket.environment_bucket.arn}/*"
        ]
      },
    ]
  })
}