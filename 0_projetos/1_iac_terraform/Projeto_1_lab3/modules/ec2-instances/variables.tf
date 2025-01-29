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
  default     = ["lab3-t1-terraform", "lab3-t2-terraform", "lab3-t3-terraform"]
}
