# create a vpc
resource "aws_vpc" "hashicat" {
  cidr_block = "10.0.0.0/16"
}
