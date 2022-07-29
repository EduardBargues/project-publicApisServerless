variable "public_domain" {
  type        = string
  description = "(Required) Defines the main domain (url) that will expose your services to internet. Example: my-man.cloud"
}

variable "sub_domain" {
  type        = string
  description = "(Required) Defines the url that is unique for the environment being deployed. Will prefix the public_domain variable. Example: api (api.my-man.cloud)"
}

# -----

locals {
  full_public_domain = "${var.sub_domain}.${var.public_domain}"
}
