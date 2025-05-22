resource "aws_s3_bucket" "terraform_backend" {
    bucket = "epcn-eng-plat-terraform-backend"

    versioning {
        enabled = true
    }

}
