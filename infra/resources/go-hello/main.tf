module "service" {
  source                  = "../../modules/service"
  ecs_cluster_id          = var.ecs_cluster_id
  service_name            = "go-hello"
  task_execution_role_arn = var.task_execution_role_arn
  subnet_ids              = var.private_subnet_ids
  security_group_ids      = [var.ecs_security_group_id]
  container_image         = var.container_image
  cpu                     = var.cpu
  memory                  = var.memory
  ecr_repository_url      = var.ecr_repository_url
  image_tag               = var.image_tag
}