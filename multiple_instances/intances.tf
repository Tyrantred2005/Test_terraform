variable "instances" {
  description = "Instances names"
  type        = list(string)
  default     = [ "tomcat_az1", "tomcat_az2" ] 
}

resource "aws_instance" "public_instance" {
    count                   = length(var.instances)
    ami                     = "${var.ami_id}"
    instance_type           = "${var.instance_type}"
    subnet_id               = aws_subnet.public_subnet_az[count.index].id
    key_name                = data.aws_key_pair.key.key_name
    vpc_security_group_ids  = [aws_security_group.SG_Public_instance.id]
    user_data               = <<EOF
        #!/bin/bash
        sudo su
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        echo "<html><h1> Welcome to TOMCAT on AZ_[count.index] </p> </h1> </html>" > /usr/share/testpage/index.html
        EOF

    tags = {
    Name = "Tomcat AZ[count.index]"
    }
} 
