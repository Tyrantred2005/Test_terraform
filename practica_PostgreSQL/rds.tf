#create a security group for RDS Database Instance
resource "aws_security_group" "rds_postgresql_sg" {
  name = "rds_postgresql_sg"
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
}

#create db_parameter_group
resource "aws_db_parameter_group" "lab" {
  name = "lab"
  family = "postgres13"

  parameter {
    name = "log_connections"
    value = "1"
  }
}

#create db_subnet_group
resource "aws_db_subnet_group" "rds_subnet" {
  name       = "rds_subnet"
  subnet_ids = [aws_subnet.public_subnet.id]

  tags = {
    Name = "rds subnet group"
  }
}

#create a RDS Database Instance
resource "aws_db_instance" "mypostgresql" {
  engine               = "postgres"
  identifier           = "mypostgresinstance"
  allocated_storage    =  10
  engine_version       = "13.7"
  instance_class       = "db.t3.micro"
  username             = "myrdsuser"
  password             = "myrdspassword"
  parameter_group_name = aws_db_parameter_group.lab.name
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids = ["${aws_security_group.rds_postgresql_sg.id}"]
  skip_final_snapshot  = true
  publicly_accessible =  true
  tags = {
  Name = "PABLO-My-first-rds"
  }
}