variable "instance_type" {
    description = "Tipo de instância a ser criada"
  
}

variable "ami" {
    description = "Amazon Machine Image(AMI) a ser criada pela instância"
  
}

variable "region" {
    description = "Região da AWS onde a instância será criada"
    default     = "us-east-2"
  
}

provider "aws" {
    region = var.region
  
}

resource "aws_instance" "exemple" {
    ami = var.ami
    instance_type = var.instance_type

    tags = {
      Name = "tarefa1_terraform"
    }
  
}