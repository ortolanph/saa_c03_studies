resource "aws_vpc" "db_vpc" {
  cidr_block = "10.0.0.0/16"

  # Those two needed to be enabled to support RDS to be public
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = "${var.workspace}-db-vpc"
    workspace = var.workspace
    exam      = "saa_c03"
  }

  tags_all = {
    Name      = "${var.workspace}-db-vpc"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id = aws_vpc.db_vpc.id

  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name      = "${var.workspace}-subnet-a"
    workspace = var.workspace
    exam      = "saa_c03"
  }

  tags_all = {
    Name      = "${var.workspace}-subnet-a"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id = aws_vpc.db_vpc.id

  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true

  tags = {
    Name      = "${var.workspace}-subnet-b"
    workspace = var.workspace
    exam      = "saa_c03"
  }

  tags_all = {
    Name      = "${var.workspace}-subnet-b"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_subnet" "subnet_c" {
  vpc_id = aws_vpc.db_vpc.id

  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-west-1c"
  map_public_ip_on_launch = true

  tags = {
    Name      = "${var.workspace}-subnet-c"
    workspace = var.workspace
    exam      = "saa_c03"
  }

  tags_all = {
    Name      = "${var.workspace}-subnet-c"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_security_group" "database_security_group" {
  vpc_id = aws_vpc.db_vpc.id
  name   = "${var.workspace}-database-security-group"

  ingress {
    description = "PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # I had add this because Terraform does not add an outbound rule
  egress {
    description = "Default Outbound Rule"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags_all = {
    Name      = "${var.workspace}-database-security-group"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

# Needed to create this to support database to be public
resource "aws_internet_gateway" "database_internet_gateway" {
  vpc_id = aws_vpc.db_vpc.id

  tags = {
    Name      = "${var.workspace}-database-internet-gateway"
    workspace = var.workspace
    exam      = "saa_c03"
  }

  tags_all = {
    Name      = "${var.workspace}-database-internet-gateway"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_route" "simple_route" {
  route_table_id = aws_vpc.db_vpc.main_route_table_id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.database_internet_gateway.id
}

