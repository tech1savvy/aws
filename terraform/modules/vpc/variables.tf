variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/27"
}

variable "public_a_cidr" {
  description = "CIDR block for public subnet a"
  type        = string
  default     = "10.0.0.0/28"
}

variable "public_b_cidr" {
  description = "CIDR block for public subnet b"
  type        = string
  default     = "10.0.0.16/28"
}

variable "az_a" {
  description = "Availability zone a"
  type        = string
  default     = "ap-south-1a"
}

variable "az_b" {
  description = "Availability zone b"
  type        = string
  default     = "ap-south-1b"
}