resource "aws_security_group" "sg_bamr_proj_1_lab3" {
  name = "sg_bamr_proj_1_lab3"
  description = "Security Group EC2 Instance"

  ingress {

    description = "Inbound Rule"
    from_port = 22
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    description = "Outbound Rule"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    }
}

resource "aws_instance" "web_server" {
    count           = length(var.instance_tags)
    ami             = var.ami_cod
    instance_type   = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg_bamr_proj_1_lab3.id]
    
    user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              sudo bash -c 'echo Criando um Web Server com Terraform na DSA - Instance ${count.index + 1} > /var/www/html/index.html'
              EOF


    tags = {
        Name = var.instance_tags[count.index]
    } 

}

output "instance_id" {
  value = aws_instance.web_server.*.id
}

/* 
o código abaixo, completamente comentado é outra prposta de solução
Coloquei as variáveis nesse código, para não alterar o arquivo variables.tf
provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "sg_bamr_proj_1_lab3" {
  
  name = "sg_bamr_proj_1_lab3"
  
  description = "Security Group EC2 Instance"

  ingress {

    description = "Inbound Rule"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    description = "Outbound Rule"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    }

}

variable "web_servers" {
  description = "Configuração dos servidores web"
  type = map(object({
    name = string
  }))
  default = {
    "server1" = {
      name = "Server1"
    },
    "server2" = {
      name = "Server2"
    },
    "server3" = {
      name = "Server3"
    }
  }
}

resource "aws_instance" "web_server" {
  
  for_each = var.web_servers

    ami           = "ami-0a0d9cf81c479446a" 
  
    instance_type = "t2.micro"

    vpc_security_group_ids = [aws_security_group.sg_permite_http_web.id]

    tags = {
      Name = each.value.name
    }

    user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install httpd -y
                sudo systemctl start httpd
                sudo systemctl enable httpd
                sudo bash -c 'echo Criando o Web Server com Terraform na DSA > /var/www/html/index.html'
                EOF
}


*/ 