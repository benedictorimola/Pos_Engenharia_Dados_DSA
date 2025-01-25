# Fundamentos Terraform - parte 2

## 1) Neste capítulo:
- Tarefa 5: desenvolvimento de scripts utilizando módulos específicos para criação de recursos em clou e trabalhando com variáveis de saída.

__lab2_tarefa 3__

Usar os mesmos recursos do Dockfile da tarefa 2 \
Para efeitos de exercício, criar o diretório tarefa 3 e usar o vi para criar os arquivos dessse lab \

``` bash
Estrutura básica com informações para criação de EC2
ami, instance_type, subnet_id e tag(identifica com um nome a EC2 a ser criada)
resource "aws_instance" "bamr_instance_1" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnets[0]

    tags = {
      Name = "BAMR instance 1"
    }
  
}
```
__lab2_tarefa 4__
``` bash
O Que São Módulos no Terraform?
Um  módulo  pode  ser  reutilizado  em  diferentes  projetos  ou  em  diferentes  partes do mesmo projeto. \
Organizar  o  código  Terraform  em  módulos  é  uma  prática  excelente  para  criar  uma infraestrutura reutilizável, de fácil manutenção e escalável. \
Um  bom  ponto  de  partida  é  organizar  seus  arquivos  em  uma  estrutura  de  diretórios lógica. 
```
Essa tarefa trabalha com um módulo denominado ec2