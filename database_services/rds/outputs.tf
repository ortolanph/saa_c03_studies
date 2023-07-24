output "database_dns" {
  value = aws_db_instance.database.address
}

output "psql_command_line_sample" {
  value = "psql -h ${aws_db_instance.database.address} -d ${aws_db_instance.database.db_name} -U ${var.username} -W"
}
