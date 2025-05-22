resource "aws_ecs_task_definition" "this" {
    family                   = var.service_name
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = var.cpu
    memory                   = var.memory
    execution_role_arn       = var.task_execution_role_arn

    container_definitions = jsonencode([
        {
            name      = var.service_name
            image     = "${var.ecr_repository_url}:${var.image_tag}"
            cpu       = var.cpu
            memory    = var.memory
            essential = true
            portMappings = [
                {
                    containerPort = 8080
                    hostPort      = 8080
                    protocol      = "tcp"
                }
            ]
        }
    ])
}

resource "aws_ecs_service" "this" {
    name            = var.service_name
    cluster         = var.ecs_cluster_id
    task_definition = aws_ecs_task_definition.this.arn
    launch_type     = "FARGATE"
    desired_count   = 1

    network_configuration {
        subnets          = var.subnet_ids
        security_groups  = var.security_group_ids
        assign_public_ip = true
    }
}