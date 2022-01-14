data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = var.org
    workspaces = {
      name = var.workspace_name
    }
  }
}

provider "aws" {
  default_tags {
    tags = local.common_tags
  }

  region = data.terraform_remote_state.network.outputs.region
}

locals {
  subnets = {
    prod  = data.terraform_remote_state.network.outputs.production_subnet_id
    stage = data.terraform_remote_state.network.outputs.staging_subnet_id
    dev   = data.terraform_remote_state.network.outputs.development_subnet_id
  }
  vpc_id = data.terraform_remote_state.network.outputs.main_vpc
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

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = lookup(local.subnets, var.environment, "fail")

  tags = merge(
    local.common_tags,
    {
      Name  = "${var.org}-${var.environment}-bastion-instance"
      owner = "Solutions Engineer"
      ttl   = "1"
    },
  )
}

output "bastion_ip" {
  value = aws_instance.bastion.private_ip
}