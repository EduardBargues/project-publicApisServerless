variable "service" {
  type    = string
  default = "project_aws_serverless"
}

variable "layer" {
  type    = string
  default = "security"
}

variable "environment" {
  type        = string
  description = "(Required) Name of the environment being deployed to. DEV, TEST, QA, PRODUCTION, ..."
}

variable "aws_region" {
  type        = string
  description = "(Required) AWS region where the deployment happens."
}

variable "aws_account_id" {
  type        = string
  description = "(Required) AWS account where the deployment happens."
}

variable "repository_url" {
  type        = string
  description = "(Required) Http address of the repository this infrastructure is deployed from."
  default     = "https://github.com/EduardBargues/project-publicApisServerless"
}
