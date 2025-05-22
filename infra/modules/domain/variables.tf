variable "aws_region" {
  description = "The AWS region to deploy the infrastructure."
  type        = string
  default     = "us-east-1" 
}

variable "env_id" {
  description = "The environment identifier."
  type        = string
  default     = "alpha"
}

variable "env_domain" {
  description = "The environment domain."
  type        = string
  default     = "linuxtips.local"
}

# hack #

variable "cert_validation_records" {
  description = "Map of ACM certificate validation records."
  type = map(object({
    resource_record_name  = string
    resource_record_type  = string
    resource_record_value = string
  }))
  default = {}
}