resource "aws_autoscaling_group" "chapter02_autoscaling_group" {
  name_prefix = "${local.workspace}-autoscaling-group"
  desired_capacity   = 4
  max_size           = 7
  min_size           = 1

  vpc_zone_identifier  = data.aws_subnets.chapter_02_subnets

  health_check_type = "EC2"

  # Launch Template
  launch_template {
    id      = aws_launch_template.chapter02_launch_template.id
    version = aws_launch_template.chapter02_launch_template.latest_version
  }

  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = [ "desired_capacity" ]
  }   

  tag {
    key                 = "workspace"
    value               = local.workspace
    propagate_at_launch = true
  }
}
