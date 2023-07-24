output "database_vpc_id" {
  value = aws_vpc.db_vpc.id
}

output "database_subnets" {
  value = [
    aws_subnet.subnet_a.id,
    aws_subnet.subnet_b.id,
    aws_subnet.subnet_c.id,
  ]
}

output "database_security_group_id" {
  value = aws_security_group.database_security_group.id
}
