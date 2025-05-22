provider "aws" {
    region = var.aws_region
}

module "foundation" {
    source = "../../modules/foundation"
    aws_region = var.aws_region
    env_domain = var.env_id
    env_id = var.env_id
    env_domain = var.env_domain
}

// IAM Roles + Policies
// ECR WIP
// VPC + Subnets + IGW + ...
// ALB + Target Group + Listener + Rules
// ECS / EkS / ROSA / .
// Container up

