locals {
  prefix = "${var.service}_${var.environment}"

  tags = {
    service        = var.service
    environment    = var.environment
    layer          = var.layer
    repository_url = var.repository_url
  }
}
