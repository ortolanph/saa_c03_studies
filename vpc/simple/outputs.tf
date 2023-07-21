output "vpc_id" {
  value = aws_vpc.simple_vpc.id
}

output "subnet_id" {
  value = aws_subnet.simple_subnet.id
}

output "eni_id" {
  value = aws_network_interface.simple_network_interface.id
}

output "igw_id" {
  value = aws_internet_gateway.simple_internet_gateway.id
}

output "security_group_id" {
  value = aws_security_group.simple_security_group.id
}