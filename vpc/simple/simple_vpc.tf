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

  cidr_block = "172.16.100.0/24"
  availability_zone = "eu-west-1a"
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
  gateway_id = aws_internet_gateway.simple_internet_gateway.id
}
