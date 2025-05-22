variable certificate_arn {
  description = "The ARN of the ACM certificate to validate."
  type        = string
}

variable "cert_validation_fqdn" {
  description = "The FQDN of the ACM certificate to validate."
  type        = string
}