resource "aws_s3_bucket" "s3_lifecycle_bucket" {
  bucket = "${local.workspace}-my-small-enterprise"

  tags = {
    Name      = "${local.workspace}-my-small-enterprise"
    workspace = local.workspace
  }
}

resource "aws_s3_bucket_public_access_block" "s3_lifecycle_bucket_public_access" {
  bucket = aws_s3_bucket.s3_lifecycle_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "s3_lifecycle_lifecycle_versioning" {
  bucket = aws_s3_bucket.s3_lifecycle_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "s3_lifecycle_bucket_objects" {
  for_each = fileset("files/lifecycle/", "**/*.*")

  bucket = aws_s3_bucket.s3_lifecycle_bucket.id
  key    = each.value
  source = "files/lifecycle/${each.value}"
  etag   = filemd5("files/lifecycle/${each.value}")
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_lifecycle_bucket_object_lifecycle" {
  bucket = aws_s3_bucket.s3_lifecycle_bucket.id

  rule {
    id     = "sales-rule"
    status = "Enabled"

    filter {
      prefix = "sales-docs/"
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 365
      storage_class = "GLACIER"
    }
  }
}