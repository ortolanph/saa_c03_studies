resource "aws_dynamodb_table" "nosql_database" {
  name           = "${var.workspace}-books-database"
  billing_mode   = "PROVISIONED"
  read_capacity  = "1"
  write_capacity = "1"
  hash_key       = "Id"
  range_key      = "Title"
  stream_enabled = false

  attribute {
    name = "Id"
    type = "N"
  }

  attribute {
    name = "Title"
    type = "S"
  }

  global_secondary_index {
    hash_key        = "Title"
    name            = "TitleIndex"
    projection_type = "ALL"
    read_capacity   = 10
    write_capacity  = 10
  }
  
  ttl {
    attribute_name = "ExpiresAt"
    enabled        = "true"
  }

  tags = {
    Name      = "${var.workspace}-books-database"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}
