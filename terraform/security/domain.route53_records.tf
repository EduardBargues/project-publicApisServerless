locals {
  route53_records = {
    sub = {
      allow_overwrite = true
      name            = local.full_public_domain
      type            = "NS"
      ttl             = 30
      zone_id         = aws_route53_zone.main["main"].zone_id
      records = [
        aws_route53_zone.main["sub"].name_servers[0],
        aws_route53_zone.main["sub"].name_servers[1],
        aws_route53_zone.main["sub"].name_servers[2],
        aws_route53_zone.main["sub"].name_servers[3]
      ]
    }
  }
}
resource "aws_route53_record" "main" {
  for_each = local.route53_records

  allow_overwrite = each.value.allow_overwrite
  name            = each.value.name
  type            = each.value.type
  ttl             = each.value.ttl
  zone_id         = each.value.zone_id

  records = each.value.records
}
