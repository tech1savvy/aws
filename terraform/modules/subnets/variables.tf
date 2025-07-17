variable "vpc_id" {
  description = "The ID of the VPC to create subnets in"
  type        = string
}

variable "public_a_cidr" {
  description = "CIDR block for public subnet a"
  type        = string
}

variable "public_b_cidr" {
  description = "CIDR block for public subnet b"
  type        = string
}

variable "az_a" {
  description = "Availability zone a"
  type        = string
}

variable "az_b" {
  description = "Availability zone b"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "key-sensei"
}