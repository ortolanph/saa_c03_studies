resource "aws_s3_bucket" "s3_website_bucket" {
  bucket = "${local.workspace}-website"

  tags = {
    Name      = "${local.workspace}-website"
    workspace = local.workspace
  }
}

resource "aws_s3_bucket_public_access_block" "s3_website_bucket_public_access" {
  bucket = aws_s3_bucket.s3_website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "s3_website_bucket_versioning" {
  bucket = aws_s3_bucket.s3_website_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "s3_website_bucket_policy" {
  bucket = aws_s3_bucket.s3_website_bucket.id
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
                "${aws_s3_bucket.s3_website_bucket.arn}/*"
            ]
        }
    ]
}
POLICY
}

resource "aws_s3_object" "s3_website_bucket_objects" {
  for_each = fileset("files/website/", "**/*.*")

  bucket = aws_s3_bucket.s3_website_bucket.id
  key    = each.value
  source = "files/website/${each.value}"
  etag   = filemd5("files/website/${each.value}")
}


resource "aws_s3_bucket_website_configuration" "s3_website_bucket_configuration" {
  depends_on = [
    aws_s3_bucket.s3_website_bucket,
    aws_s3_bucket_public_access_block.s3_website_bucket_public_access,
    aws_s3_bucket_versioning.s3_website_bucket_versioning,
    aws_s3_bucket_policy.s3_website_bucket_policy,
    aws_s3_object.s3_website_bucket_objects
  ]

  bucket = aws_s3_bucket.s3_website_bucket.id

  index_document {
    suffix = "index.html"
  }
}