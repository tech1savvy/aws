resource "aws_launch_template" "main" {
  name_prefix   = "${var.project_name}-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [var.ec2_sg_id]

  user_data = base64encode(file("${path.module}/user_data.sh"))
}