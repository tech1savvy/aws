output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}