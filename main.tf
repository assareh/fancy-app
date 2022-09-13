provider "tfe" {
}

data "tfe_outputs" "control_workspace" {
  organization = var.control_workspace_organization
  workspace    = var.control_workspace_workspace
}

provider "aws" {
  region = var.region
}

data "aws_subnet" "this" {
  id = lookup(data.tfe_outputs.control_workspace.values.subnets, var.environment, null)
}
