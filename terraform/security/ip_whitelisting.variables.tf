variable "allowed_ips" {
  type        = list(string)
  default     = []
  description = "(Optional) Defines the set of IP RANGES to be whitelisted."
}
