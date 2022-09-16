provider "tfe" {
}

data "tfe_outputs" "control_workspace" {
  organization = var.control_workspace_organization
  workspace    = var.control_workspace_workspace
}

provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn     = var.aws_role_arn
    session_name = var.TFC_RUN_ID
  }
}

data "aws_subnet" "this" {
  id = lookup(data.tfe_outputs.control_workspace.values.subnets, var.environment, null)
}

data "aws_ami" "amazon-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amazon-linux.id
  instance_type = "t3.micro"
}

output "instance_id" {
  value = aws_instance.example.id
}