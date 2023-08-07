#Create public instances
resource "aws_instance" "tomcat_az1" {
    ami                     = "${var.ami_id}"
    instance_type           = "${var.instance_type}"
    subnet_id               = aws_subnet.public_subnet_az1.id
    key_name                = data.aws_key_pair.key.key_name
    vpc_security_group_ids  = [aws_security_group.SG_Public_instance.id]
    user_data               = file("scripts/userdata_1.sh")

    tags = {
    Name = "Tomcat AZ1"
    }
} 

resource "aws_instance" "tomcat_az2" {
    ami                     = "${var.ami_id}"
    instance_type           = "${var.instance_type}"
    subnet_id               = aws_subnet.public_subnet_az2.id
    key_name                = data.aws_key_pair.key.key_name
    vpc_security_group_ids  = [aws_security_group.SG_Public_instance.id]
    user_data               = file("scripts/userdata_2.sh")
    
    tags = {
    Name = "Tomcat AZ2"
    }
} 