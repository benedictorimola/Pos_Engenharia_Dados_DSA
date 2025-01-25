variable "instance_count" {
    description = "Número de instâncias EC2 a serem criadas"
    type = number
  
}

variable "ami_id" {
    description = "AMD ID das instâncias"
    type = string
  
}

variable "instance_type" {
    description = "Tipo de Instância"
    type = string
  
}

variable "subnet_id" {
    description = "Subnet_id das instâncias"
    type = string
  
}