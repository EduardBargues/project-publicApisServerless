locals {
  ip_whitelisting = {
    main={
      ip_set_addresses =var.allowed_ips
      ip_set_name =local.prefix
      waf_web_acl_name =local.prefix
    }
  }
}
module "waf" {
  for_each = local.ip_whitelisting

  source = "./modules/waf"

  ip_set_addresses = each.value.ip_set_addresses
  ip_set_name      = each.value.ip_set_name
  waf_web_acl_name = each.value.waf_web_acl_name
}
