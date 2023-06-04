output "ec2_instance_public_dns" {
  value = aws_instance.chapter_02_instance.public_dns
}

output "ec2_instance_public_ip_address" {
  value = aws_instance.chapter_02_instance.public_ip
}
