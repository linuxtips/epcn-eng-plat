resource "aws_acm_certificate" "this" {
    domain_name               = "${var.env_id}.${var.env_domain}"
    validation_method         = "DNS"
    
}

