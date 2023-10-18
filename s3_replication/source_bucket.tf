resource "aws_s3_bucket" "s3_source_certificate_bucket" {
  bucket = "certificates-bucket-source-bucket"

  tags = {
    Name = "certificates-bucket-source-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_source_certificate_bucket_public_access" {
  bucket = aws_s3_bucket.s3_source_certificate_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "s3_source_certificate_bucket_versioning" {
  bucket = aws_s3_bucket.s3_source_certificate_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "s3_source_certificate_replication_configuration" {
  bucket = aws_s3_bucket.s3_source_certificate_bucket.id
  role   = aws_iam_role.s3_replication_role.arn

  rule {
    id     = "certificate_replication"
    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.s3_target_certificate_bucket.arn
      storage_class = "STANDARD"
    }
  }
}
