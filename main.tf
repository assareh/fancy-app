provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "hashicat" {
  cidr_block = "10.10.0.0/16"
}
