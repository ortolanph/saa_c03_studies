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

resource "aws_security_group" "chapter_02_security_group" {
  name        = "${local.workspace}-ssh-security-group"
  description = "A security group that allows only port 22"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${local.workspace}-ssh-security-group"
    workspace = local.workspace
  }

}

data "aws_key_pair" "chapter_02_key_pair" {
  key_name = "chapter_02_key_pair"
}

# Cluster placement groups are not supported by the 't2.micro' instance type
#resource "aws_placement_group" "chapter_02_instance_placement_group" {
#  name     = "${local.workspace}-placement-group"
#  strategy = "cluster"
#
#  tags = {
#    Name      = "${local.workspace}-placement-group"
#    workspace = local.workspace
#  }
#}

resource "aws_instance" "chapter_02_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id                   = data.aws_subnets.chapter_02_subnets.ids[0]
  security_groups             = [aws_security_group.chapter_02_security_group.id]
  associate_public_ip_address = true
  key_name                    = data.aws_key_pair.chapter_02_key_pair.key_name

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  user_data = <<EOF
#!/usr/bin/env bash

echo "========================================================================="
sudo apt-get install tree -y
sudo mkfs -t ext4 /dev/sdh
sudo mkdir /mnt/my_ebs_disk
sudo mount /dev/sdh /mnt/my_ebs_disk
tree /mnt > /home/ec2-user/contents.txt
echo "========================================================================="
EOF

  tenancy         = "default"
  //placement_group = aws_placement_group.chapter_02_instance_placement_group.id

  tags = {
    Name      = "${local.workspace}_my_instance"
    workspace = local.workspace
  }
}

data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_ebs_volume" "chapter_02_volume" {
  availability_zone = data.aws_availability_zones.azs.names[0]
  size              = 10
  type              = "gp2"

  tags = {
    Name      = "${local.workspace}_my_volume"
    workspace = local.workspace
  }
}

resource "aws_volume_attachment" "chapter_02_volume" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.chapter_02_volume.id
  instance_id = aws_instance.chapter_02_instance.id
}