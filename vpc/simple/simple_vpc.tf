resource "aws_vpc" "simple_vpc" {
  cidr_block = "172.16.0.0/16"

  tags_all = {
    Name      = "${var.workspace}-simple-vpc"
    workspace = var.workspace
    exam      = "saa_c03"
  }
}