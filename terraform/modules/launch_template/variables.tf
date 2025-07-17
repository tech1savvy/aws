variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "key-sensei"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "The key pair name for SSH access"
  type        = string
}

variable "ec2_sg_id" {
  description = "The ID of the EC2 security group"
  type        = string
}