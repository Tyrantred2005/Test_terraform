resource "aws_vpc" "vpc_california" {
  cidr_block = var.california_cidr
  tags = {
    Name = "VPC_CALIFORNIA"
    env  = "dev"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc_california.id
  cidr_block       = var.public_subnet
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc_california.id
  cidr_block       = var.private_subnet
  tags = {
    Name = "Private_subnet"
  }
}
