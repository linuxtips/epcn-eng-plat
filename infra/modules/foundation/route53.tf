

resource "aws_route53_zone" "this" {
    name = "${var.env_id}.${var.env_domain}"
}