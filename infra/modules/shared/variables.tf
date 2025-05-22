variable "aws_region" {
  description = "The AWS region to deploy the infrastructure."
  type        = string
}

variable "env_domain" {
  description = "The environment domain."
  type        = string
}

variable "env_id" {
  description = "The environment identifier."
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the ACM certificate."
  type        = string
  
}