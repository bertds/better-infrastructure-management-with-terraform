resource "aws_s3_bucket" "notebook_bucket" {
  bucket = "sagemaker-notebook-bucket-${var.student_name}"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "notebook_bucket_policy" {
  bucket = aws_s3_bucket.notebook_bucket.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*Object"
        Resource = [
          aws_s3_bucket.notebook_bucket.arn,
          "${aws_s3_bucket.notebook_bucket.arn}/*",
        ]
        Condition = {
          NotIpAddress = {
            "aws:SourceIp" = aws_subnet.main.cidr_block
          }
        }
      },
    ]
  })
}