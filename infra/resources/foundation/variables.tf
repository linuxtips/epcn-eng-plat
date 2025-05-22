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