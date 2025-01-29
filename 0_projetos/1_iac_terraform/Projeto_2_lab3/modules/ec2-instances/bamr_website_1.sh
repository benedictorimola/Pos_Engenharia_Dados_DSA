#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo bash -c 'echo Primeiro Web Server com Terraform - BAMR > /var/www/html/index.html'