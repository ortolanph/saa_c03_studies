resource "aws_vpc" "simple_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name      = "${var.workspace}-simple-vpc"
    workspace = var.workspace
    exam      = "saa_c03"
  }

  tags_all = {
    Name      = "${var.workspace}-simple-vpc"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_subnet" "simple_subnet" {
  vpc_id = aws_vpc.simple_vpc.id

  cidr_block              = "172.16.100.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name      = "${var.workspace}-simple-subnet"
    workspace = var.workspace
    exam      = "saa_c03"
  }

  tags_all = {
    Name      = "${var.workspace}-simple-subnet"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_network_interface" "simple_network_interface" {
  subnet_id = aws_subnet.simple_subnet.id

  private_ip = "172.16.100.99"

  tags = {
    Name      = "${var.workspace}-simple-network-interface"
    workspace = var.workspace
    exam      = "saa_c03"
  }

  tags_all = {
    Name      = "${var.workspace}-simple-network-interface"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_internet_gateway" "simple_internet_gateway" {
  vpc_id = aws_vpc.simple_vpc.id

  tags = {
    Name      = "${var.workspace}-simple-internet-gateway"
    workspace = var.workspace
    exam      = "saa_c03"
  }

  tags_all = {
    Name      = "${var.workspace}-simple-internet-gateway"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_route" "simple_route" {
  route_table_id = aws_vpc.simple_vpc.main_route_table_id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.simple_internet_gateway.id
}

resource "aws_security_group" "simple_security_group" {
  vpc_id = aws_vpc.simple_vpc.id
  name   = "${var.workspace}-simple-security-group"

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
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
    Name      = "${var.workspace}-simple-security-group"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_network_acl_rule" "allow_ssh" {
  network_acl_id = aws_vpc.simple_vpc.default_network_acl_id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 70
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "allow_rdp" {
  network_acl_id = aws_vpc.simple_vpc.default_network_acl_id
  protocol       = "tcp"
  rule_action    = "allow"
  rule_number    = 80
  cidr_block     = "0.0.0.0/0"
  from_port      = 3389
  to_port        = 3389
}