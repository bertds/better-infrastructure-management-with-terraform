// TO DO: create your own bucket

resource "aws_s3_bucket" "bucketbert" {
  bucket = "my-tf-test-bucket-bert"
  acl    = "private"
}