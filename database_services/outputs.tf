#output "database_dns" {
#  value       = module.rds.database_dns
#  description = "Comment this if you ignored RDS"
#}
#
#output "psql_command_line_connect" {
#  value       = module.rds.psql_command_line_connect
#  description = "Comment this if you ignored RDS"
#}
#
#output "psql_command_line_create_table" {
#  value       = module.rds.psql_command_line_create_table
#  description = "Comment this if you ignored RDS"
#}
#
#output "psql_command_line_inserts" {
#  value       = module.rds.psql_command_line_inserts
#  description = "Comment this if you ignored RDS"
#}
#
#output "psql_command_line_queries" {
#  value       = module.rds.psql_command_line_queries
#  description = "Comment this if you ignored RDS"
#}
#
#output "psql_command_line_connect_replica" {
#  value       = module.rds.psql_command_line_connect_replica
#  description = "Comment this if you ignored RDS"
#}

output "dynamodb_table_name" {
  value       = module.dynamo.dynamodb_table_name
  description = "Comment this if you ignored DynamoDB"
}
