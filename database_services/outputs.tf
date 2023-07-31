output "database_dns" {
  value = module.rds.database_dns
}

output "psql_command_line_connect" {
  value = module.rds.psql_command_line_connect
}

output "psql_command_line_create_table" {
  value = module.rds.psql_command_line_create_table
}

output "psql_command_line_inserts" {
  value = module.rds.psql_command_line_inserts
}

output "psql_command_line_queries" {
  value = module.rds.psql_command_line_queries
}
