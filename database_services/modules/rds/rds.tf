resource "aws_db_subnet_group" "database_subnet_group" {
  name       = "${var.workspace}-database-subnet-group"
  subnet_ids = var.subnets

  tags = {
    Name      = "${var.workspace}-database-subnet-group"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_db_instance" "database" {
  identifier = "${var.workspace}-database"

  instance_class    = "db.t3.micro"
  allocated_storage = 20

  copy_tags_to_snapshot = true

  db_name  = var.workspace
  engine   = "postgres"
  username = var.username
  password = var.password
  port     = 5432

  publicly_accessible     = "true"
  skip_final_snapshot     = "true"
  backup_retention_period = 7

  vpc_security_group_ids = [var.security_group_id]

  db_subnet_group_name = aws_db_subnet_group.database_subnet_group.name

  tags = {
    Name      = "${var.workspace}-database"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_db_instance" "database_replica" {
  depends_on = [aws_db_instance.database]

  identifier = "${var.workspace}-database-replica"

  instance_class          = "db.t3.micro"
  backup_retention_period = 7
  replicate_source_db     = aws_db_instance.database.identifier
  skip_final_snapshot     = "true"
  publicly_accessible     = "true"

  tags = {
    Name      = "${var.workspace}-database-replica"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}
