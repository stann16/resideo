#!/bin/bash
yum update -y
yum install -y tomcat
systemctl start tomcat
systemctl enable tomcat

