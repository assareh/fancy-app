provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "hashicat" {
  cidr_block = "10.0.0.0/16"
}

terraform {
  cloud {
    organization = "hashidemos"
    hostname = "app.terraform.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["fancy-app"]
    }
  }
}
