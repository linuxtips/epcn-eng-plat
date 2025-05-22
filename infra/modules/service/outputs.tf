output "ecs_cluser_id" {
  value = aws_ecs_cluster.main.id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.main.arn
}

output "task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}
