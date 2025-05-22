resource "aws_route53_zone" "this" {
  name = "${var.env_id}.${var.env_domain}"
}

data "aws_route53_zone" "parent" {
    name         = var.env_domain
    private_zone = false
}

resource "aws_route53_record" "delegation" {
    zone_id = data.aws_route53_zone.parent.zone_id
    name    = aws_route53_zone.this.name
    type    = "NS"
    ttl     = 300
    records = aws_route53_zone.this.name_servers
}