variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "alb_sg_id" {
  description = "The ID of the ALB security group"
  type        = string
}



variable "ssh_cidr" {
  description = "CIDR block for SSH access"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "key-sensei"
}