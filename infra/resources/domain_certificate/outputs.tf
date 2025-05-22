output "certificate_arn" {
  value       = module.domain_certificate.certificate_arn
  description = "The ARN of the ACM certificate"
}

