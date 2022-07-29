locals {
  acms = {
    sub = {
      domain_name         = local.full_public_domain
      zone_id             = aws_route53_zone.main["sub"].zone_id
      wait_for_validation = false
    }
  }
}
module "acm" {
  for_each = local.acms

  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name         = each.value.domain_name
  zone_id             = each.value.zone_id
  wait_for_validation = each.value.wait_for_validation
}
