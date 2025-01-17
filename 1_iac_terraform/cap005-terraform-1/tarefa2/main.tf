provider "aws" {
    region = var.region
  
}

resource "aws_instance" "ec2_exemple" {
    ami = var.ami
    instance_type = var.instance_type
    
    tags = {
      Name = var.tag
    }
  
}