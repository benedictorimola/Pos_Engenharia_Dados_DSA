## Fundamentos Terraform - parte 1

__lab2 tarefa 1__: automatizando a infraestrutura na AWS com ariáveis no terraform. Use os scripts aa pasta tarefa1

``` bash
# Instruções do Lab 2
# Abra o terminal ou prompt de comando e navegue até a pasta onde você colocou os arquivos do Lab2 (não use espaço ou acento em nome de pasta)
# Execute o comando abaixo para criar a imagem Docker

docker build -t bamr-terraform-image:lab2 .
# -t cria uma tag

# Execute o comando abaixo para criar o container Docker
docker run -dit --name bamr-lab2 bamr-terraform-image:lab2 /bin/bash
# -d (detached - background) 
# -it acessar no modo interativo.  Pode fechar o terminal, mas o container contunuará em execução.
# -- name <nome do container> <nome da imagem>

# Verifique as versões do Terraform e do AWS CLI com os comandos abaixo
terraform version
aws --version
```

``` bash
# Após a criação do container, executar as instruções abaixo:
- acesse a AWS com suas credenciais
- navegue até o diretório onde está localizado o arquivo main.tf
Execute os comandos:
terraform init

terraform plan -var 'instance_type=t2.micro' -var 'ami=ami-0a0d9cf81c479446a' -out lab2-plan.txt

terraform apply -var 'instance_type=t2.micro' -var 'ami=ami-0a0d9cf81c479446a'

terraform destroy -var 'instance_type=t2.micro' -var 'ami=ami-0a0d9cf81c479446a'
```

__lab2 tarefa 2__: Usando arquivos de variáveis. Use os scripts aa pasta tarefa2 \
[Exemplo](https://jhooq.com/terraform-variable-and-tfvars-file/#2-terraform-tfvars-file---terraformtfvars)

``` bash
# Usando arquivos de variáveis
crie o arquivo .tfvars e defina nome e valor das variáveis
crie o arquivo .tf para definir as variáveis

# Execute o comando abaixo para criar a imagem Docker
docker build -t bamr-terraform-image:lab2 .
# -t cria uma tag

# Execute o comando abaixo para criar o container Docker
docker run -dit --name bamr-lab2 bamr-terraform-image:lab2 /bin/bash
# -d (detached - background) 
# -it acessar no modo interativo.  Pode fechar o terminal, mas o container contunuará em execução.
# -- name <nome do container> <nome da imagem>

# Verifique as versões do Terraform e do AWS CLI com os comandos abaixo
terraform version
aws --version

- acesse a AWS com suas credenciais
- navegue até o diretório onde está localizado o arquivo main.tf

terraform init -var-file="tarefa2.tfvars"
terraform plan -var-file="tarefa2.tfvars"
terraform apply -var-file="tarefa2.tfvars"
terraform destroy -var-file="tarefa2.tfvars"

```

