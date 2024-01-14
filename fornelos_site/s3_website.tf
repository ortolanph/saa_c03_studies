resource "aws_s3_bucket" "fornelos_site" {
  bucket = "${local.workspace}-website"

  tags = {
    Name      = "${local.workspace}-website"
    workspace = local.workspace
  }
}

resource "aws_s3_bucket_public_access_block" "fornelos_site_public_access" {
  bucket = aws_s3_bucket.fornelos_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "fornelos_site_bucket_versioning" {
  bucket = aws_s3_bucket.fornelos_site.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "fornelos_policy" {
  bucket = aws_s3_bucket.fornelos_site.id
  policy = <<-POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "WebSitePolicy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "${aws_s3_bucket.fornelos_site.arn}",
                "${aws_s3_bucket.fornelos_site.arn}/*"
            ]
        }
    ]
}
POLICY
}

#resource "aws_s3_bucket_cors_configuration" "example" {
#  bucket = aws_s3_bucket.fornelos_site
#  cors_rule {
#    allowed_headers = ["Authorization", "Content-Length"]
#    allowed_methods = ["GET", "POST"]
#    allowed_origins = ["https://www.${local.workspace}-website"]
#    max_age_seconds = 3000
#  }
#}

resource "aws_s3_object" "fornelos_site_bucket_objects" {
  for_each = fileset("files/website/", "**/*.*")

  bucket = aws_s3_bucket.fornelos_site.id
  key    = each.value
  source = "files/website/${each.value}"
  etag   = filemd5("files/website/${each.value}")
}


resource "aws_s3_bucket_website_configuration" "fornelos_site_configuration" {
  depends_on = [
    aws_s3_bucket.fornelos_site,
    aws_s3_bucket_public_access_block.fornelos_site_public_access,
    aws_s3_bucket_versioning.fornelos_site_bucket_versioning,
    aws_s3_bucket_policy.fornelos_policy,
    aws_s3_object.fornelos_site_bucket_objects
  ]

  bucket = aws_s3_bucket.fornelos_site.id

  index_document {
    suffix = "index.html"
  }
}