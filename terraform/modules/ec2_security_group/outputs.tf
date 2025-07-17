output "ec2_sg_id" {
  description = "The ID of the EC2 security group"
  value       = aws_security_group.main.id
}