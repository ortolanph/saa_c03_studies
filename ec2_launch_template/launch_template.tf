resource "aws_launch_template" "chapter02_launch_template" {
  name                   = "${local.workspace}_launch_template"
  update_default_version = true

  // AMI
  image_id = var.ami_id

  // Instance type
  instance_type = var.instance_type

  // Key Pair
  key_name = data.aws_key_pair.chapter_02_key_pair.key_name

  // Network Settings
  network_interfaces {
    subnet_id = data.aws_subnets.chapter_02_subnets.ids[0]
  }

  vpc_security_group_ids = [
    aws_security_group.chapter_02_security_group_launch_configuration.id
  ]

  // Storage
  block_device_mappings {
    device_name = "/dev/sdb"

    ebs {
      volume_size = 10
      delete_on_termination = true
    }
  }

  block_device_mappings {
    device_name = "/dev/sdc"

    ebs {
      volume_size = 10
      delete_on_termination = true
    }
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  // Advanced Options
  placement {
    tenancy = "default"
  }

  // User data
  user_data = filebase64("${path.module}/user_data.sh")

  // Tags
  tags = {
    Name      = "${local.workspace}_launch_template"
    workspace = local.workspace
  }

}

resource "aws_instance" "chapter02_launch_template_instance" {
  launch_template {
    name = aws_launch_template.chapter02_launch_template.name
  }

  tags = {
    Name      = "${local.workspace}_my_instance_from_launch_template"
    workspace = local.workspace
  }
}
