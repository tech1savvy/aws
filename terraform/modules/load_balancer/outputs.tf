output "lb_target_group_arn" {
  value = aws_lb_target_group.main.arn
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer."
  value       = aws_lb.main.dns_name
}
