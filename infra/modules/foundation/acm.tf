resource "aws_acm_certificate" "this" {
    domain_name               = "${var.env_id}.${var.env_domain}"
    validation_method         = "DNS"
    subject_alternative_names = ["*.${var.env_id}.${var.env_domain}"]

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_route53_record" "cert_validation" {
    for_each = {
        for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
            name   = dvo.resource_record_name
            type   = dvo.resource_record_type
            record = dvo.resource_record_value
        }
    }

    zone_id = aws_route53_zone.this.zone_id
    name    = each.value.name
    type    = each.value.type
    records = [each.value.record]
    ttl     = 60
}

resource "aws_acm_certificate_validation" "this" {
    certificate_arn         = aws_acm_certificate.this.arn
    validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}