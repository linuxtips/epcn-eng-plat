output "certificate_arn" {
  value       = aws_acm_certificate.this.arn
  description = "The ARN of the ACM certificate"
}

output "cert_validation_fqdn" {
    value       = tolist(aws_acm_certificate.this.domain_validation_options).0.resource_record_name
    description = "The validation options for the ACM certificate"
}

