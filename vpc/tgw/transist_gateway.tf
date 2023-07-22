resource "aws_vpc" "tgw_vpc" {
  cidr_block = "172.17.0.0/16"

  tags = {
    Name      = "${var.workspace}-tgw-vpc"
    workspace = var.workspace
    exam      = "saa_c03"
  }

  tags_all = {
    Name      = "${var.workspace}-tgw-vpc"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_subnet" "tgw_subnet" {
  vpc_id = aws_vpc.tgw_vpc.id

  cidr_block              = "172.17.100.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true

  tags = {
    Name      = "${var.workspace}-tgw-subnet"
    workspace = var.workspace
    exam      = "saa_c03"
  }

  tags_all = {
    Name      = "${var.workspace}-tgw-subnet"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_ec2_transit_gateway" "tgw_transit_gateway" {
  description                    = "Transit Gateway"
  auto_accept_shared_attachments = "enable"

  tags = {
    Name      = "${var.workspace}-transit_gateway"
    workspace = var.workspace
    exam      = "saa_c03"
  }

  tags_all = {
    Name      = "${var.workspace}-transit_gateway"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_vpc_attachment_my_side" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw_transit_gateway.id
  vpc_id             = aws_vpc.tgw_vpc.id
  subnet_ids         = [aws_subnet.tgw_subnet.id]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_vpc_attachment_other_side" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw_transit_gateway.id
  vpc_id             = var.simple_vpc_id
  subnet_ids         = [var.simple_vpc_subnet_id]
}

resource "aws_route" "route_to_simple_vpc" {
  route_table_id = var.simple_vpc_route_table_id

  destination_cidr_block = aws_vpc.tgw_vpc.cidr_block
  transit_gateway_id     = aws_ec2_transit_gateway.tgw_transit_gateway.id
}

resource "aws_route" "route_to_tgw_vpc" {
  route_table_id = aws_vpc.tgw_vpc.main_route_table_id

  destination_cidr_block = var.simple_vpc_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.tgw_transit_gateway.id
}

resource "aws_ec2_transit_gateway_route" "blackhole" {
  destination_cidr_block         = "172.16.100.64/29"
  transit_gateway_route_table_id = aws_ec2_transit_gateway.tgw_transit_gateway.association_default_route_table_id
  blackhole                      = true
}
// create a tgw blackhole route
