resource "aws_s3_bucket" "s3_presigned_bucket" {
  bucket = "${local.workspace}-presigned-objects"

  tags = {
    Name      = "${local.workspace}-presigned-objects"
    workspace = local.workspace
  }
}

resource "aws_s3_bucket_public_access_block" "s3_presigned_bucket_public_access" {
  bucket = aws_s3_bucket.s3_presigned_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "s3_presigned_bucket_versioning" {
  bucket = aws_s3_bucket.s3_presigned_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "s3_presigned_object_image" {
  bucket = aws_s3_bucket.s3_presigned_bucket.id
  key    = "movie_devourer.png"
  source = "files/presigned/movie_devourer.png"
}

resource "null_resource" "presign_image" {
  depends_on = [
    aws_s3_object.s3_presigned_object_image,
  ]

  provisioner "local-exec" {
    command = "aws s3 presign s3://${aws_s3_bucket.s3_presigned_bucket.id}/${aws_s3_object.s3_presigned_object_image.key} --profile saa_c03_studies --region eu-west-1 >> image.url"
  }
}

resource "aws_s3_object" "s3_presigned_object_text" {
  bucket = aws_s3_bucket.s3_presigned_bucket.id
  key    = "message.txt"
  source = "files/presigned/message.txt"
}

resource "null_resource" "presign_text" {
  depends_on = [
    aws_s3_object.s3_presigned_object_image,
  ]

  provisioner "local-exec" {
    command = "aws s3 presign s3://${aws_s3_bucket.s3_presigned_bucket.id}/${aws_s3_object.s3_presigned_object_text.key} --profile saa_c03_studies --region eu-west-1 >> text.url"
  }
}

resource "aws_s3_object" "s3_presigned_object_audio" {
  bucket = aws_s3_bucket.s3_presigned_bucket.id
  key    = "audio_message.mp3"
  source = "files/presigned/audio_message.mp3"
}

resource "null_resource" "presign_audio" {
  depends_on = [
    aws_s3_object.s3_presigned_object_image,
  ]

  provisioner "local-exec" {
    command = "aws s3 presign s3://${aws_s3_bucket.s3_presigned_bucket.id}/${aws_s3_object.s3_presigned_object_audio.key} --profile saa_c03_studies --region eu-west-1 >> audio.url"
  }
}