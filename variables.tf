variable "environment" {}
variable "name" {}
variable "org" {}
variable "workspace_name" {}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Owner       = var.name
    Purpose     = var.workspace_name
    Environment = var.environment
  }
}
