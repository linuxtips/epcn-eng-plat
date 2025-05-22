output "zone_id" {
  value       = aws_route53_zone.this.zone_id
  description = "The ID of the Route 53 hosted zone"
}

output "zone_name" {
  value       = aws_route53_zone.this.name
  description = "The name of the Route 53 hosted zone"
}
