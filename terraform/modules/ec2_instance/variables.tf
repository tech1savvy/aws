variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0a1235697f4afa8a4"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ec2_sg_id" {
  description = "ID of the EC2 security group"
  type        = string
}

variable "public_subnet_a_id" {
  description = "ID of public subnet a"
  type        = string
}

variable "public_subnet_b_id" {
  description = "ID of public subnet b"
  type        = string
}

variable "lb_target_group_arn" {
  description = "ARN of the load balancer target group"
  type        = string
}