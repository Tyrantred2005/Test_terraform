resource "aws_vpc" "vpc_california" {
  cidr_block = var.california_cidr
  tags = {
    Name = "VPC_CALIFORNIA"
    env  = "dev"
  }
}

resource "aws_subnet" "public_subnet_az1" {
  vpc_id = aws_vpc.vpc_california.id
  cidr_block       = var.public_subnet_az1
  availability_zone = var.az1
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_subnet_AZ1"
  }
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id = aws_vpc.vpc_california.id
  cidr_block       = var.public_subnet_az2
  availability_zone = var.az2
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_subnet_AZ2"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc_california.id
  cidr_block       = var.private_subnet
  tags = {
    Name = "Private_subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_california.id 

  tags = {
    Name = "IGW VPC CALIFORNIA"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_california.id 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id 
  }

  tags = {
    Name = "Public route table"
  }
}

resource "aws_route_table_association" "rta_public_az1_subnet" {
  subnet_id      = aws_subnet.public_subnet_az1.id 
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "rta_public_az2_subnet" {
  subnet_id      = aws_subnet.public_subnet_az2.id 
  route_table_id = aws_route_table.public_rt.id
}

