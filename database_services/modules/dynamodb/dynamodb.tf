resource "aws_dynamodb_table" "nosql_database" {
  name           = "${var.workspace}-books-database"
  billing_mode   = "PROVISIONED"
  read_capacity  = "1"
  write_capacity = "1"
  hash_key       = "Id"
  range_key      = "BookName"
  stream_enabled = false

  attribute {
    name = "Id"
    type = "N"
  }

  attribute {
    name = "BookName"
    type = "S"
  }

  global_secondary_index {
    hash_key        = "BookName"
    name            = "BookIndex"
    projection_type = "ALL"
    read_capacity   = 1
    write_capacity  = 1
  }

  attribute {
    name = "LastName"
    type = "S"
  }

  global_secondary_index {
    hash_key        = "LastName"
    name            = "LastNameIndex"
    projection_type = "ALL"
    read_capacity   = 1
    write_capacity  = 1
  }

  attribute {
    name = "FirstName"
    type = "S"
  }

  global_secondary_index {
    hash_key        = "FirstName"
    name            = "FirstNameIndex"
    projection_type = "ALL"
    read_capacity   = 1
    write_capacity  = 1
  }

  tags = {
    Name      = "${var.workspace}-books-database"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}
