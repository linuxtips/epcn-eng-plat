resource "aws_ecr_repository" "main" {
    name                 = "${var.env_id}-epcn-repository"
} 