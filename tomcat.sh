#!/bin/bash
yum update -y
yum install -y java-1.8.0-openjdk
yum install -y tomcat
systemctl start tomcat
systemctl enable tomcat

yum install -y unzip
yum install -y aws-cli
curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip
unzip /tmp/terraform.zip -d /usr/local/bin/
aws configure

