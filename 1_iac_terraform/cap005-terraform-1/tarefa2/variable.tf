variable "instance_type" {
    type = string
    description = "Tipo de instância a ser criada"
  
}

variable "ami" {
    type = string
    description = "Amazon Machine Image(AMI) a ser criada pela instância"
  
}

variable "region" {
    type = string
    description = "Região da AWS onde a instância será criada"
    default     = "us-east-2"
  
}

variable "tag" {
    type = string
    description = "Tag par a a instância EC2"
  
}