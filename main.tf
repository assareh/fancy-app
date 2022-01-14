data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = "hashicorp"
    workspaces = {
      name = "${var.org}/${var.workspace_name}"
    }
  }
}

provider "aws" {
  region = data.terraform_remote_state.network.outputs.region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  name          = "${var.org}-${var.environment}-web-instance"
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = lookup(local.subnets, var.environment, "fail")

  tags = {
    Name  = "ProdCon - ${var.environment} - Instance"
    owner = "Solutions Engineer"
    ttl   = "1"
  }
}

locals {
  subnets = {
    prod  = data.terraform_remote_state.network.outputs.production_subnet_id
    stage = data.terraform_remote_state.network.outputs.staging_subnet_id
    dev   = data.terraform_remote_state.network.outputs.development_subnet_id
  }
}
