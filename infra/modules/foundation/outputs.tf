output "repository_url" {
    value = aws_ecr_repository.main.repository_url
}

output "ecr_login_command" {
    value       = "aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.main.repository_url}"
    description = "Command to login to the ECR repository"
}
output "vpc_id" {
    value       = aws_vpc.main.id
    description = "The ID of the VPC"
}

output "ecs_cluster_id" {
    value       = aws_ecs_cluster.main.id
    description = "The ID of the ECS Cluster"
}


output "alb_dns_name" {
    value       = aws_lb.main.dns_name
    description = "The DNS name of the ALB"
}
output "alb_arn" {
    value       = aws_lb.main.arn
    description = "The ARN of the ALB"
}

output "public_subnet_ids" {
    value       = aws_subnet.public[*].id
    description = "The IDs of the public subnets"
}

output "private_subnet_ids" {
    value       = aws_subnet.private[*].id
    description = "The IDs of the private subnets"
}

output "public_availability_zones" {
    value       = aws_subnet.public[*].availability_zone
    description = "The availability zones of the public subnets"
}

output "private_availability_zones" {
    value       = aws_subnet.private[*].availability_zone
    description = "The availability zones of the private subnets"
}