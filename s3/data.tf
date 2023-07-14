data "local_file" "image_url" {
  depends_on = [
    null_resource.presign_image
  ]
  filename = "${path.module}/image.url"
}

data "local_file" "text_url" {
  depends_on = [
    null_resource.presign_text
  ]
  filename = "${path.module}/text.url"
}

data "local_file" "audio_url" {
  depends_on = [
    null_resource.presign_image
  ]
  filename = "${path.module}/audio.url"
}