# FUNdAMENTOS TERRAFORM - PARTE 3

## 1) Terraform Provisioners

[Documentação](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax) 

__Evite provisioners sempre que possível.__

No Terraform, **provisioners** são mecanismos que permitem executar ações específicas em recursos após sua criação ou destruição. Eles são utilizados principalmente para tarefas que não podem ser realizadas diretamente pelas configurações do Terraform, como executar scripts, configurar servidores, instalar pacotes ou configurar arquivos no recurso criado.

Embora os provisioners sejam úteis em alguns casos, eles geralmente são recomendados apenas como último recurso, já que o Terraform prioriza uma abordagem declarativa. Usar provisioners pode introduzir problemas de idempotência (a capacidade de obter o mesmo resultado sempre que o código for aplicado) e dificultar a manutenção do estado do Terraform.

---
### Quando usar provisioners?

Os provisioners são úteis em situações como:
- Configurações específicas que precisam ser feitas após a criação do recurso.
- Execução de scripts de inicialização em servidores que não podem ser gerenciados diretamente por outros métodos (como Ansible ou Cloud-Init).

### Recomendações:
- **Evite provisioners sempre que possível**. Muitas vezes, as funcionalidades nativas do Terraform ou ferramentas especializadas como Ansible, Chef ou Puppet podem substituir os provisioners de forma mais eficiente e confiável.
- Use provisioners apenas como última alternativa e de forma consciente para minimizar problemas de reprodutibilidade e complexidade.

### Tipos de provisioners no Terraform:

1. **local-exec**: 
   - Executa comandos localmente na máquina onde o Terraform está sendo executado.
   - Exemplo: 
     ```hcl
     resource "aws_instance" "example" {
       ami           = "ami-123456"
       instance_type = "t2.micro"

       provisioner "local-exec" {
         command = "echo 'Instância criada!'"
       }
     }
     ```

2. **remote-exec**: 
   - Executa comandos remotamente no recurso criado, como uma máquina virtual. Geralmente, é necessário configurar uma conexão (SSH, WinRM, etc.).
   - Exemplo:
     ```hcl
     resource "aws_instance" "example" {
       ami           = "ami-123456"
       instance_type = "t2.micro"

       provisioner "remote-exec" {
         inline = [
           "sudo apt update",
           "sudo apt install -y nginx"
         ]

         connection {
           type     = "ssh"
           user     = "ubuntu"
           private_key = file("~/.ssh/id_rsa")
           host     = self.public_ip
         }
       }
     }
     ```

3. **File provisioner**:
   - Utilizado para copiar arquivos ou diretórios do host local para um recurso remoto.
   - Exemplo:
     ```hcl
     resource "aws_instance" "example" {
       ami           = "ami-123456"
       instance_type = "t2.micro"

       provisioner "file" {
         source      = "script.sh"
         destination = "/tmp/script.sh"

         connection {
           type     = "ssh"
           user     = "ubuntu"
           private_key = file("~/.ssh/id_rsa")
           host     = self.public_ip
         }
       }
     }
     ```

---

``` bash
Os provisioners no Terraform são usados para executar scripts ou ações em uma máquina local ou em uma máquina remota, principalmente no momento da criação ou destruição de um recurso.

Há dois tipos principais de provisionadores no Terraform: Creation-Time e Destroy-Time.

Creation-Time Provisioners: Como o nome sugere, esses provisionadores são executados no  momento  da  criação  de  um  recurso.  
Eles  são  usados  principalmente  para  inicializar  um recurso  com  configurações  específicas,  executar  scripts  após  a  criação  de  um  recurso  ou  para configurar  dependências  que  não  podem  ser  gerenciadas  diretamente  pelo  Terraform.  

Por exemplo, você pode usar um provisionador de criação para configurar um servidor recém-criado com um script de inicialização.Os  provisionadores  de  criação  sósão  executados  durante  a  criação  do  recurso.  Se  o recurso já existe, o provisionador não será executado, a menos que o recurso seja recriado (por exemplo, após um terraform destroy ou uma mudança que requer a reconstrução do recurso).

--
Destroy-Time  Provisioners:  
Estes  são  executados  no  momento  em  que  um  recurso  é destruído. Eles são úteis para realizar ações de limpeza ou para gerenciar dependências externas que precisam ser modificadas ou removidas quando um recurso é destruído. Por exemplo, você pode  usar  um  provisionador  de  destruição  para  desregistrar  um  dispositivo  de  um  sistema  de monitoramento quando o recurso é removido.Os provisionadores de destruição têm algumas limitações. Eles são executados antes que o recurso seja realmente destruído, o que significa que o recurso ainda existe (mas está prestes a  ser  destruído)  quando  o  provisionador  é  executado.  

Além  disso,  se  o  recurso  já  está  em  um estado  corrompido  ou  não  gerenciável,  o  provisionador  de  destruição  pode  não  ser  capaz  de executar corretamente.É  importante  usar  provisionadores  com  cautela  no  Terraform.  Eles  podem  adicionar complexidade e comportamentos imprevisíveis. O ideal é que a maior parte da configuração e gestão de recursos seja feita de forma declarativa, usando as capacidades nativas doTerraform e dos provedores de recursos, reservando os provisionadores para casos em que não há outra alternativa viável.
```


## 2) Instruções Lab3 
#### 2.1) Tarefa1

- Abra o terminal ou prompt de comando e navegue até a pasta onde você colocou os arquivos do Lab3 (não use espaço ou acento em nome de pasta)


- Execute o comando abaixo para criar a imagem Docker \
docker build -t bamr-terraform-image:lab3 .


- Execute o comando abaixo para criar o container Docker \
docker run -dit --name dsa-lab3 -v ./Lab3:/lab3 dsa-terraform-image:lab3 /bin/bash

- NOTA: No Windows você deve substituir ./Lab3 pelo caminho completo da pasta, por exemplo: C:\DSA\Cap07\Lab3 \
docker run -dit --name dsa-lab3 -v ./Lab3:/lab3 dsa-terraform-image:lab3 /bin/bash

- Verifique as versões do Terraform e do AWS CLI com os comandos abaixo
terraform version
aws --version
    
#### 2.2) Tarefa4
O lab3 tem uma demonstração de utilização de provisioner "remote-exec". \
Essa demonstração consiste na criação de um servidor web, através das tarefas 2, 3 e 4. \
As tarefas 2 e 3 possuem algumas simulações de erros, que implicam em ajustes nas instâncias EC2, via console. \
Optei por documentar e exercitar a tarefa4, que é uma evolução das tarefas 2 e 3. \
A tarefa 4, tem como insfraestrutura um servidor web em uma instância EC2, configurada, via script bash e associada a um security group.