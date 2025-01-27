## Criação de Security Group 
resource "aws_security_group" "bamr_ssh" {
    name = var.security_group_1
    description = "Security Group EC2 Instance"

    ingress  {
        description = "Inbound Rule"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress  {
        description = "Outbound Rule"
        from_port   = 20
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

## Criação de Instância EC2
resource "aws_instance" "bamr_instance" {
    ami     = var.ami_name
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.bamr_ssh.id]
    
    user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              sudo bash -c 'echo Criando um Web Server com Terraform na DSA > /var/www/html/index.html'
              EOF    

    tags    = { Name = "lab3-tarefa5-terraform"}




}
