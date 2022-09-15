provider "tfe" {
}

data "tfe_outputs" "control_workspace" {
  organization = var.control_workspace_organization
  workspace    = var.control_workspace_workspace
}

provider "aws" {
  region = var.region

  assume_role {
    role_arn     = var.aws_role_arn
    session_name = var.TFC_RUN_ID
  }
}

data "aws_subnet" "this" {
  id = lookup(data.tfe_outputs.control_workspace.values.subnets, var.environment, null)
}

output "temp" {
  value = lookup(data.tfe_outputs.control_workspace.values.subnets, var.environment, null)
}