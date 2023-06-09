output "launch_template_arn" {
  description = "Launch template ARN"
  value       = aws_launch_template.chapter02_launch_template.arn
}

output "launch_template_id" {
  description = "Lauch template ID"
  value       = aws_launch_template.chapter02_launch_template.id
}

output "launch_template_latest_version" {
  description = "Latest version of the template version"
  value       = aws_launch_template.chapter02_launch_template.latest_version
}

output "ec2_instance_public_dns" {
  description = "EC2 instance public DNS"
  value       = aws_instance.chapter02_launch_template_instance.public_dns
}

output "ec2_instance_public_ip_address" {
  description = "EC2 instance public IP"
  value       = aws_instance.chapter02_launch_template_instance.public_ip
}
