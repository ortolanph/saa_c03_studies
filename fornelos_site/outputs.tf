output "website_url" {
  value = aws_s3_bucket_website_configuration.fornelos_site_configuration.website_endpoint
}
