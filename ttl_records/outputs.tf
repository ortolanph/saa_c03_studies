output "dynamodb_table_name" {
  value       = module.dynamo.dynamodb_table_name
  description = "Comment this if you ignored DynamoDB"
}
