output "ec2_instance_public_dns" {
  description = "EC2 instance public DNS"
  value       = aws_instance.chapter_02_instance.public_dns
}

output "ec2_instance_public_ip_address" {
  description = "EC2 instance public IP"
  value       = aws_instance.chapter_02_instance.public_ip
}
