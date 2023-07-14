output  "image_url" {
  value = data.local_file.image_url.content
}

output  "text_url" {
  value = data.local_file.text_url.content
}

output  "audio_url" {
  value = data.local_file.audio_url.content
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.s3_website_bucket_configuration.website_endpoint
}