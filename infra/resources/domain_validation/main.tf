module "domain_validation" {
    source = "../../modules/domain_validation"
    certificate_arn = var.certificate_arn
    cert_validation_fqdn = var.cert_validation_fqdn
}