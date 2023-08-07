output "Tomcat_az1_public_ip" {
  description = "EC2 instance public IP"
  value = aws_instance.tomcat_az1.public_ip
}

output "Tomcat_az2_public_ip" {
  description = "EC2 instance public IP"
  value = aws_instance.tomcat_az2.public_ip
}