resource "aws_s3_bucket" "s3_target_certificate_bucket" {
  bucket = "certificates-bucket-target-bucket"

  tags = {
    Name = "certificates-bucket-target-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_target_certificate_bucket_public_access" {
  bucket = aws_s3_bucket.s3_target_certificate_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "s3_target_certificate_bucket_bucket_versioning" {
  bucket = aws_s3_bucket.s3_target_certificate_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
