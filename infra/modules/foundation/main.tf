provider "aws" {
    region = var.aws_region
}

resource "aws_ecr_repository" "main" {
    name                 = "epcn-repository"
} 