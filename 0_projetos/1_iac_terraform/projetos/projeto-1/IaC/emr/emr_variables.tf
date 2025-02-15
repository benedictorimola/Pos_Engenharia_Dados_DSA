# Definição da variável 'project'
variable "project" { }

# Definição da variável 'environment'
variable "environment" { }

# Definição da variável 'tags'
variable "tags" { }

# Definição da variável 'key_name'
variable "key_name" { }

# Definição da variável 'vpc_id'
variable "vpc_id" { }

# Definição da variável 'public_subnet'
variable "public_subnet" { }

# Definição da variável 'additional_security_group_id'
variable "additional_security_group_id" { }

# Definição da variável 'release_label'
variable "release_label" { }

# Definição da variável 'applications'
variable "applications" { }

# Definição da variável 'main_instance_type'
variable "main_instance_type" { }

# Definição da variável 'core_instance_type'
variable "core_instance_type" { }

# Definição da variável 'core_instance_count'
variable "core_instance_count" { }

# Definição da variável 'core_instance_ebs_volume_size' com valor padrão
variable "core_instance_ebs_volume_size" { default = "80" }

# Definição da variável 'security_configuration_name' com valor padrão nulo
variable "security_configuration_name" { default = null }

# Definição da variável 'log_uri' com valor padrão (substitua account-id pelo id da sua conta)
# Crie previamente o bucket-s3 para este projeto.
# Como forma de exercício, pode ser cirada uma versão, onde o bucket-s3 seja criado pelo próprio projeto,
variable "log_uri" { default = "s3://bamr-iac-projeto1-236334286" }

# Definição da variável 'configurations' com valor padrão nulo
variable "configurations" { default = null }

# Definição da variável 'steps' com tipo complexo e valor padrão nulo
variable "steps" {
  type = list(object(
    {
      name = string
      action_on_failure = string
      hadoop_jar_step = list(object(
        {
          args       = list(string)
          jar        = string
          main_class = string
          properties = map(string)
        }
      ))
    }
  ))
  default = null
}

# Definição da variável 'bootstrap_action' com valor padrão vazio
variable "bootstrap_action" {
  type = set(object(
    {
      name = string
      path = string
      args = list(string)
    }
  ))
  default = []
}

# Definição da variável 'kerberos_attributes' com valor padrão vazio
variable "kerberos_attributes" {
  type = set(object(
    {
      kdc_admin_password = string
      realm              = string
    }
  ))
  default = []
}