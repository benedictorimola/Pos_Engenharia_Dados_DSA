# PROJETO 1
## Objetivo
### IMPORTANTE: Este projeto gera cobrança na AWS
Desenvolver solução robusta e escalável para processamento de dados, aproveitando as capacidades do AWS EMR (Elastic MapReduce) e do framework Apache Flink, através de IaC com Terraform.

## Aprendizado
Automatizar a configuração e o gerenciamento da infraestrutura necessária  para executar pipelines de processamento de dados em lote e streaming, capazes de lidar com grandes volumes de dados com baixa latência.

## Links úteis
### [Amazon EMR](https://aws.amazon.com/pt/emr)
### [Apache Flink](https://flink.apache.org/)

``` bash
Pré-requisitos:
- Criação de bucket-s3
Crie um bucket-s3 que armanezará o log dos jobs que serão submetidos nesse lab.
A título de melhoria, a criação do bucket-s3 pode ser feita pelo IaC desse projeto.
Este bucket será utilizado no arquivo emr_variables.tf

- Criação de termination policy
Como este projeto será cobrado pelo tempo que o cluster estiver ativo, criei uma política de encerramento automático por tempo de ociosidade.
Essa definição está em auto_termination_policy, no script emr.tf
``` 
## Instruções
1) Acesse a página do [EMR](https://aws.amazon.com/pt/emr) na AWS para criação de cluster e veja quais são as configurações necessárias para este projeto.  A ideia é conhecer o que é será efetivamente construído, via terraform. \
Os pacotes utilizados nesse projeto de criação de cluster serão: 

- Apache Flink
- Zepellin
- Hadoop
- Hive

2) Criação do container

``` bash
# Abra o terminal ou prompt de comando e navegue até a pasta onde você colocou os arquivos do Lab5 (não use espaço ou acento em nome de pasta)


# Execute o comando abaixo para criar a imagem Docker

docker build -t bamr-terraform-image:iac-p1 .

# Execute o comando abaixo para criar o container Docker

docker run -dit --name bamr-iac-p1 -v ./IaC:/iac bamr-terraform-image:p1 /bin/bash

NOTA: No Windows você deve substituir ./IaC pelo caminho completo da pasta, por exemplo: C:\DSA\Cap12\IaC

# Verifique as versões do Terraform e do AWS CLI com os comandos abaixo

terraform version
aws --version
```

3) Instruções par aexecução do projeto
``` bash
# Projeto 1 - Provisionando Infraestrutura de Processamento de Dados com AWS EMR e Apache Flink

1) Crie um bucket no S3 chamado <nome_bucket> e configure no arquivo emr.tf

2) Inicializa o Terraform
terraform init

3) Cria o Plan e salva em disco
terraform plan -var-file config.tfvars -out terraform.tfplan

4) Aqui são duas opções de execução, mas a melhor opção é o terrform plan
# Executa o apply com o arquivo de variáveis (com auto-approve)
terraform apply -auto-approve -var-file config.tfvars
# Executa o apply com o arquivo de variáveis (sem auto-approve)
terraform apply -var-file config.tfvars

5) Conexão via SSH ao master do cluster
# No container Docker navegue até a pasta onde estão as chaves criadas no deploy do cluster
# Após a execução de criação do cluster será gerada a pasta generated com as chaves ssh
# Acesse o cluster, no console AWS e em "Cluster management" escolha a opção "Connect to the Primary node using SSH" para recuperar o comando de conexão, via ssh, que será usado para acesso, via container
# No container acesse a pasta generated/ssh e ajuste o privilégio da chave privada, apenas para leitura
chmod 400 deployer

6) Conecta via SSH (coloque abaixo o endereço do seu cluster)
# Usar o endereço público do cluster que foi criado pelo Terraform. Cada vez que o cluster for criado, será gerado um endereço diferente.
ssh -i deployer hadoop@ec2-3-14-149-89.us-east-2.compute.amazonaws.com

7) Crie uma pasta como input no HDFS.  Essa pasta deverá receber um arquivo txt com um texto, que será utilizado nesse projeto.
Pode ser um texto qualquer como uma reportagem, por exemplo.
Nesse momento você está conectado no cluster EMR.
Verifique o conteúdo do diretório: hdfs dfs -ls /
Acesse o diretório: hdfs dfs -ls /user
Acesse o diretório root: hdfs dfs -ls /user/root
Crie o diretório root e, /user/root: hdfs dfs -mkdir /user/root/input

8) Copie o arquivo para o HDFS
hdfs dfs -put dados.txt /user/root/input
Mesmo que o arquivo dados.txt seja removido do cluster, tal arquivo continuará no hdfs.

9) Vamos contar o número de ocorrências de cada palavra no arquivo usando Apache Flink
flink run -m yarn-cluster /usr/lib/flink/examples/streaming/WordCount.jar --input hdfs:///user/root/input/dados.txt --output hdfs:///user/root/saida/
Caso, ao final do processamento, ocorra o erro Exception in thread "Thread-3, este evento não interferirá no resultado desejado
Este comando executará o /usr/lib/flink/examples/streaming/WordCount.jar que é um contador de palavas em um texto.

10) Copie o arquivo do HDFS para o sistema de arquivos local
10.1) Para recuperar o diretório gerado em /user/root/saida/, execute:  hdfs fs -ls /user/root/saida/
10.2) Com o resultado do comando acima, recupere os arquivos com o resultado o processamento: hdfs fs -ls /user/root/saida/<RESULTADO GERADO EM 10.1>
hdfs dfs -get /user/root/saida/2025-02-15--19/part-792b4815-5cf0-450e-9c2e-559e33627032-0
10.3) Execute ls e recupere o nome do arquivo copiado
10.4) Execute cat <nome do arquivo copiado> para acessar o conteúdo

11) Criação de etapas de execução no cluster, via linha de comando - AWS CLI
11.1) Os comandos abaixo devem ser executados no container Docker (máquina cliente).  Para isso execute o coamndo exit para sair do cluster.
11.2) Coloque o ID do seu cluster EMR
11.3) Ciração de steps no cluster para execução de jobs
# Aqui, a origem dados.txt está no cluster. Informe o cluster-id que foi gerado nesse processo.
aws emr add-steps --cluster-id j-SI78IAQDVVW4 \
--steps Type=CUSTOM_JAR,Name=Job1_P1,Jar=command-runner.jar,\
Args="flink","run","-m","yarn-cluster",\
"/usr/lib/flink/examples/streaming/WordCount.jar",\
"--input","hdfs:///user/root/input/dados.txt","--output","hdfs:///user/root/saidajob1/" \
--region us-east-2
11.4) Efetue os pasos a seguir para recuperar o arquivo gerado, da mesma forma dos passos 10.1 a 10.4.
Acesse o cluster, via console, e para  e execute: 
- hdfs dfs -ls /user/root/saidajob1/
- hdfs dfs -get /user/root/saidajob1/2025-02-15--19/part-4a55e911-e591-4a73-b55b-c6cbd1b60e7e-0
- ls
- cat <NOME ARQUIVO recuperado no passo acima>

11) Criação de job para execução, usando o S3 como armazenanto.  Essa ação será efetuada no container.
Vantahgem: ao destruir o cluster o armazenamento é mantido. 
Desvantagem: queda de performance.
11.1) Execute o comando abaixo no container.
aws emr add-steps --cluster-id j-SI78IAQDVVW4 \
--steps Type=CUSTOM_JAR,Name=Job2_P1,Jar=command-runner.jar,\
Args="flink","run","-m","yarn-cluster",\
"/usr/lib/flink/examples/streaming/WordCount.jar",\
"--input","s3://bamr-iac-projeto1-236334286/dados.txt","--output","s3://bamr-iac-projeto1-236334286/" \
--region us-east-2
11.2) Acesse o bucket e recupere o resultado do processamento de contagem de palavras.


12) Cria o Plan para o destroy e salva em disco
terraform plan -destroy -var-file config.tfvars -out terraform.tfplan

13) Executa o destroy
# Nesse caso, está sendo executado o plano de destruição que está no arquivo terraform.tfplan
terraform apply terraform.tfplan
```
