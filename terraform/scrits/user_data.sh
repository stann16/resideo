#!/bin/bash
yum update -y
yum install -y httpd
# Start the HTTPD service
systemctl start httpd
systemctl enable httpd
# Create a simple HTML page
echo "<html><body><h1>Hello, World!</h1></body></html>" > /var/www/html/index.html