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

variable "certificate_arn" {
  description = "The ARN of the ACM certificate."
  type        = string
}
