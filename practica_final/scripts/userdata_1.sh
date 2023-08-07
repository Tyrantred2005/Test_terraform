#!/bin/bash
sudo su
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<html><h1> Welcome to TOMCAT on AZ_1 </p> </h1> </html>" > /usr/share/testpage/index.html