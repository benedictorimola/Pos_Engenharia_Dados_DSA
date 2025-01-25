variable "region" {
    description = "Região da AWS onde os recursos serão criados"
    type = string
    default = "us-east-2"
  
}

variable "instance_type" {
    description = "Tipo de instância EC2"
    type = string
    default = "t2.micro"
  
}

variable "vpc_id" {
    description = "IDs da vpc onde as instãncias serão criadas"
    type = list(string)
  
}

variable "subnets" {
    description = "Subnets de cada instância da VPC"
    type = list(string)
  
}

variable "ami_id" {
    description = "AMI id para a instância EC2"
    type = string
  
}