output "web_acl" {
  value = aws_wafv2_web_acl.main
}

output "ip_rule_set_addresses" {
  value = aws_wafv2_ip_set.main.addresses
}
