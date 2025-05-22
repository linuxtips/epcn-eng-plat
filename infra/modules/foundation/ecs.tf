resource "aws_ecs_cluster" "main" {
  name = "${var.env_id}-epcn-ecs-cluster"
  tags = {
    Name = "${var.env_id}-epcn-ecs-cluster"
  }
}
