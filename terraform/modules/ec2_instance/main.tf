resource "aws_launch_template" "main" {
  name_prefix   = "key-sensei-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.ec2_sg_id]

  user_data = base64encode(file("${path.module}/user_data.sh"))
}

resource "aws_autoscaling_group" "main" {
  name                 = "key-sensei-asg"
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
  vpc_zone_identifier  = [var.public_subnet_a_id, var.public_subnet_b_id]
  target_group_arns    = [var.lb_target_group_arn]

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "key-sensei-instance"
    propagate_at_launch = true
  }
}