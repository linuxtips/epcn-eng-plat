provider "aws" {
    region = var.aws_region
}

module "domain" {
    source = "../../modules/domain"
    aws_region = var.aws_region
    env_domain = var.env_domain
    env_id = var.env_id
}