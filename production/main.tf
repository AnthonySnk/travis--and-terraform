provider "aws" {
  region = "us-east-1"
}
# build a vpc

resource "aws_vpc" "aws_vpc" {
  cidr_block = "10.50.0.0/16"

  tags = {
    Name = "TravisCIvpc-PRODUCCION"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.aws_vpc.id
  cidr_block = "10.50.1.0/24"

  tags = {
    Name = "TravisCIcreatedSubnet-PRODUCCION"
  }
}
