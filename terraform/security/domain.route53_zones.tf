locals {
  route53_zones = {
    main = {
      name = var.public_domain
    },
    sub = {
      name = local.full_public_domain
    }
  }
}
resource "aws_route53_zone" "main" {
  for_each = local.route53_zones

  name = each.value.name
}
