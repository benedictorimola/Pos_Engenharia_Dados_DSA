# DEPLOY AWS COM IaC TERRAFORM - PARTE 2

## __Descrição__
Neste capítulo será desenvolvido o Lab 5, que consiste no deploy de uma aplicação web usando container Docker na nuvem AWS com o serviço Amazon Elastic Container Service (ECS) usando balanceamento de carga e serviço DNS. 

## __Material de apoio__
### [Terraform Modules AWS](https://registry.terraform.io/search/modules?namespace=terraform-aws-modules)

### [Passing environment variables to a container](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/taskdef-envfiles.html)

### [Example task definitions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/example_task_definitions.html)


## __Instruções__
#### Como sugestão de prática, as instruções 1 e 2 podem ser feitas, via terraform.  Para este lab5 seguiremos o curso, onde as ações são realizadas via console AWS.
### 1 - Criar, via console, um bucket-S3 efetuar upload do arquivo vars.env.
### 2 - No arquivo terraform.vars alterar o valor da variável s3_env_vars_file_arn, que deverá ser o arn do arquivo vars.env bucket-S3 criado na instrução 1.
### 3 - Criar, via console, role no IAM:
AmazonECS_FullAccess \
AmazonECSTaskExecutionRolePolicy \
AmazonS3FullAccess
### 4 - Recuperar o arn da role criada no passo 3 e incluir nas variáveis "execution_role_arn" e "task_role_arn" localizadas no arquivo main.tf.

``` bash
# Abra o terminal ou prompt de comando e navegue até a pasta onde você colocou os arquivos do Lab5 (não use espaço ou acento em nome de pasta)


# Execute o comando abaixo para criar a imagem Docker

docker build -t bamr-terraform-image-lab5:lab5 .


# Execute o comando abaixo para criar o container Docker

docker run -dit --name bamr-lab5 -v ./IaC:/iac bamr-terraform-image:lab5 /bin/bash

NOTA: No Windows você deve substituir ./IaC pelo caminho completo da pasta, por exemplo: C:\DSA\Cap10\IaC

docker run -dit --name bamr-lab5 -v 
# Verifique as versões do Terraform e do AWS CLI com os comandos abaixo

terraform version
aws --version
``` 
