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

resource "aws_instance" "bamr_instance" {
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
  value = aws_instance.bamr_instance.*.id
}
