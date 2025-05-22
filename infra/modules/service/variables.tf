variable "ecs_cluster_id" {
    description = "The ECS Cluster ID"
    type        = string
}

variable "service_name" {
    description = "The name of the ECS service"
    type        = string
}

variable "task_execution_role_arn" {
    description = "The ARN of the task execution IAM role"
    type        = string
}

variable "subnet_ids" {
    description = "List of subnet IDs for the service"
    type        = list(string)
}

variable "security_group_ids" {
    description = "List of security group IDs for the service"
    type        = list(string)
}

variable "cpu" {
    description = "CPU units for the task"
    type        = number
}

variable "memory" {
    description = "Memory (in MiB) for the task"
    type        = number
}

variable "ecr_repository_url" {
    description = "The ECR repository URL to pull the image from."
    type        = string
}

variable "image_tag" {
    description = "The image tag to use from ECR."
    type        = string
}
