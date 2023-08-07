#Create SG for public instances
resource "aws_security_group" "SG_Public_instance" {
  name        = "Public instance SG"
  description = "Allow SSH & 80 inbound traffic & all egress traffic"
  vpc_id      = aws_vpc.vpc_california.id

  ingress {
    description      = "SSH over Internet"
    from_port        = 22
    to_port          = 22 
    protocol         = "tcp"
    cidr_blocks      = [var.SG_ingress_cidr]
  }

  ingress {
    description      = "Port 80 over Internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.SG_ingress_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public instance SG"
  }
}

#create a security group for RDS Database Instance
resource "aws_security_group" "rds_postgresql_sg" {
  name = "rds_postgresql_sg"
  description = "Allow tcp 5432 inbound traffic & all egress traffic"
  vpc_id      = aws_vpc.vpc_california.id
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name = "RDS Postgres SG"
  }
}