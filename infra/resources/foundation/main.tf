provider "aws" {
    region = var.aws_region
}

module "foundation" {
    source = "../../modules/foundation"
    aws_region = var.aws_region
}

// IAM Roles + Policies
// ECR WIP
// VPC + Subnets + IGW + ...
// ALB + Target Group + Listener + Rules
// ECS / EkS / ROSA / .
// Container up

