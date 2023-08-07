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
