resource "aws_ecs_cluster" "main" {
  name = "epcn-ecs-cluster"
  tags = {
    Name = "epcn-ecs-cluster"
  }
}
