resource "aws_instance" "bamr_instance" {
    ami     = "ami-0a0d9cf81c479446a"  # AMI na AWS
    instance_type = "t2.micro"
    tags    = { Name = "lab3-tarefa1-terraform"}

    provisioner "local-exec" {
        command = "echo ${aws_instance.bamr_instance.public_ip} > ip_bamr_instance.txt"
      
    }
}
