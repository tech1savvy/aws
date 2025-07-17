variable "vpc_id" {
  description = "The ID of the VPC for the route table"
  type        = string
}

variable "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  type        = string
}

variable "public_subnet_a_id" {
  description = "The ID of public subnet a"
  type        = string
}

variable "public_subnet_b_id" {
  description = "The ID of public subnet b"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "key-sensei"
}