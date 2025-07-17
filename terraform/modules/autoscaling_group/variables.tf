variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "key-sensei"
}

variable "min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
}

variable "desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "lb_target_group_arn" {
  description = "ARN of the Load Balancer Target Group"
  type        = string
}

variable "launch_template_id" {
  description = "ID of the Launch Template"
  type        = string
}

variable "cpu_utilization_target" {
  description = "Target CPU utilization for scaling"
  type        = number
}