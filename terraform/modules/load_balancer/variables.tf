variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "alb_sg_id" {
  description = "ID of the ALB security group"
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

variable "app_port" {
  description = "The application port"
  type        = number
}