variable "aws_role_arn" {
  type        = string
  description = "Amazon Resource Name of the role to be assumed"
}

variable "control_workspace_organization" {
  type        = string
  description = "Terraform organization to read VPC inputs from"
}

variable "control_workspace_workspace" {
  type        = string
  description = "Terraform workspace to read VPC inputs from"
}

variable "environment" {
  type        = string
  description = "Which environment this represents: dev, stg, prd"
}

variable "region" {
  type        = string
  description = "AWS region in which to launch resources"
  default     = "us-west-1"
}

variable "TFC_RUN_ID" {
  type        = string
  description = "Terraform Cloud automatically injects a unique identifier for this run."
  default     = ""
}