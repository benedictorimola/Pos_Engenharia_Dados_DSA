variable "project_name" {
    description = "NoMe do projeto"
    type = string
}

variable "env" {
  
}

variable "vpc_cidr_block" {
    description = "bloco de endereços IP atribuído a uma VPC"
    type = string
  
}

variable "az1" {
    description = "Zona de disponibilidade 1"
    type = string
  
}

variable "az2" {
    description = "Zona de disponibilidade 2"
    type = string
  
}

variable "public_subnet_1" {
    description = "Subnet pública 1"
    type = string
  
}

variable "public_subnet_2" {
    description = "Subnet pública 2"
    type = string
  
}

variable "private_subnet_1" {
    description = "Subnet privada 1"
    type = string
  
}

variable "alb_eg_port" {
    description = "Porta de saída"
    type = string
  
}

variable "container_port" {
    description = "Porta de saída do container"
  
}

variable "awslog_region" {
    description = "Região da AWS onde serão armazenados os logs do Cloud Watch"
  
}

variable "docker_image_name" {
    description = "Nome da imagem do Docker"
    type = string
  
}

variable "cpu" {
    description = "Define tamanho de CPU da intância ECS"
    type = string

}

variable "memory" {
    description = "Define tamanho de memória da intância ECS"
    type = string
  
}

variable "s3_env_vars_file_arn" {
    description = "Amazon Resource Name do recurso S3"
    type = string
  
}

variable "health_check_path" {
    description = "Localização dos logs de validação de saúde da instância"
    type = string
    default = "/"
  
}