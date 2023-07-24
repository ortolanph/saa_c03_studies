output "database_dns" {
  value = module.rds.database_dns
}

output "psql_command_line_sample" {
  value = module.rds.psql_command_line_sample
}
