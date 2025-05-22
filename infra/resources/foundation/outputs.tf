output "repository_url" {
    value = module.foundation.repository_url
}

output "vpc_id" {
    value = module.foundation.vpc_id
}

output "public_subnet_ids" {
    value = module.foundation.public_subnet_ids 
}

output "private_subnet_ids" {
    value = module.foundation.private_subnet_ids
}

output "alb_dns_name" {
    value = module.foundation.alb_dns_name
}

output "alb_arn" {
    value = module.foundation.alb_arn
}

output "task_execution_role_arn" {
    value = module.foundation.task_execution_role_arn
}
