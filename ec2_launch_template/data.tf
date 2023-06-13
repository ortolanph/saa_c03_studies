data "aws_key_pair" "chapter_02_key_pair" {
  key_name = "saa_c03_studies"
}

data "aws_vpc" "chapter_02_vpc" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnets" "chapter_02_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}
