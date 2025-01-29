resource "aws_security_group" "sg_bamr_proj_1_lab3" {
  name = "sg_bamr_proj_1_lab3"
  description = "Security Group EC2 Instance"

    ingress  {
        description = "Inbound Rule"
        from_port   = 22
        to_port     = 80
        protocol    = "tcp"
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

resource "aws_instance" "bamr_instance" {
    count           = length(var.instance_tags)
    ami             = var.ami_cod
    instance_type   = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg_bamr_proj_1_lab3.id]
    key_name = "dsa-lab3-bene"
    
    tags = {
        Name = var.instance_tags[count.index]
    }

    provisioner "file" {
        ### source = var.arq_config[count.index]
        source = var.arq_config[count.index]
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

output "instance_id" {
  value = aws_instance.bamr_instance.*.id
}
