## Criação de Security Group 
resource "aws_security_group" "bamr_ssh" {
    name = var.security_group_1
    description = "Security Group EC2 Instance"

    ingress  {
        description = "Inbound Rule"
        from_port   = 22
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
    
    key_name = "dsa-lab3-bene"

    tags    = { Name = "lab3-tarefa4-terraform"}

    provisioner "file" {
        source = "bamr_script.sh"
        destination = "/tmp/bamr_script.sh"

        connection {
          type = "ssh"
          user = "ec2-user"
          private_key = file("dsa-lab3-bene.pem")
          host = self.public_ip
        }
      
    }

    provisioner "remote-exec" {
        inline = [ "chmod +x /tmp/bamr_script.sh", "/tmp/bamr_script.sh" ]

        connection {
          type = "ssh"
          user = "ec2-user"
          private_key = file("dsa-lab3-bene.pem")
          host = self.public_ip
        }
      
    }


}
