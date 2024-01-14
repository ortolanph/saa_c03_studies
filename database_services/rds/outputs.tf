output "database_dns" {
  value = aws_db_instance.database.address
}

output "psql_command_line_connect" {
  value = "psql -h ${aws_db_instance.database.address} -d ${aws_db_instance.database.db_name} -U ${var.username} -W"
}

output "psql_command_line_create_table" {
  value = "psql -h ${aws_db_instance.database.address} -d ${aws_db_instance.database.db_name} -U ${var.username} -a -f .\\rds\\queries\\DDL.sql"
}

output "psql_command_line_inserts" {
  value = "psql -h ${aws_db_instance.database.address} -d ${aws_db_instance.database.db_name} -U ${var.username} -a -f .\\rds\\queries\\DML.sql"
}

output "psql_command_line_queries" {
  value = "psql -h ${aws_db_instance.database.address} -d ${aws_db_instance.database.db_name} -U ${var.username} -a -f .\\rds\\queries\\DQL.sql"
}

output "psql_command_line_connect_replica" {
  value = "psql -h ${aws_db_instance.database_replica.address} -d ${aws_db_instance.database.db_name} -U ${var.username} -W"
}
