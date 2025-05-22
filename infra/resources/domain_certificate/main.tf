provider "aws" {
    region = var.aws_region
}

module "domain_certificate" {
    source = "../../modules/domain_certificate"
    aws_region = var.aws_region
    env_domain = var.env_domain
    env_id = var.env_id
    zone_id = var.zone_id
}