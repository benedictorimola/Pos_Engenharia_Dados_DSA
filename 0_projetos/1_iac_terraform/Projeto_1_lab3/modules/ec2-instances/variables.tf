variable "instance_type" {
    description = "Tipo de instância EC2"
    default     = "t2.micro"
}

variable "ami_cod" {
    description = "Amazon Machine Image"
    default     = "ami-0a0d9cf81c479446a"
}

variable "instance_tags" {
  description = "Create Instances with these names"
  type        = list(string)
  default     = ["lab3-webserver-1", "lab3-webserver-2", "lab3-t3-webserver-3"]
}
