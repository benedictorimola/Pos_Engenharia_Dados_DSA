# DEPLOY AWS COM IaC TERRAFORM - PARTE 1


## [Arquitetura](https://github.com/benedictorimola/Pos_Engenharia_Dados_DSA/blob/main/1_iac_terraform/cap008-deploy-iac-parte1/Projeto_app.png)

__Objetivo:__ \
Desenvolver um processo completo de automação de uma aplicação com uma API fazendo a interação entre o front-end (página web) e o back-end (modelo de Machine Learning).

__Etapa 1:__ \
Efetuar deploy local para testar a aplicação e na sequência vamos construir o processo de automação com o Terraform.

__Definição e arquitetura:__ \
O objetivo deste Lab é desenvolver e implementar uma solução de infraestrutura na nuvem usando Terraform para hospedar uma aplicação de Data Science na AWS. 

Esta aplicação será focada em um modelo de Machine Learning (ML) projetado para prever seclientes vão realizar novas compras com base em seus históricos de gastos.

__Especificações do Lab Desenvolvimento de Modelo de ML:__
- Construir um modelo de Machine Learning que utilize dados históricos de compras de clientes para prever futuras ações de compra.
- Garantir a precisão e eficiência do modelo.
__Implementação de Infraestrutura na AWS:__
- Utilizar serviços AWS para hospedar e executar a aplicação, incluindo Amazon EC2, S3 e IAM.
- Garantir segurança, escalabilidade e alta disponibilidade da infraestrutura.

__Automatização com Terraform:__
- Empregar Terraform para automatizar a implantação da infraestrutura na AWS, assegurando uma implementação consistente e eficiente.
- Documentar o código Terraform para facilitar a manutenção e atualizações futuras.

__Desenvolvimento de API:__
- Criar uma API para integrar o modelo de ML com a aplicação de front-end.- Assegurar que a API seja segura, escalável e de fácil utilização.

__Resultados Esperados:__ \
A conclusão bem-sucedida deste Lab resultará em uma aplicação de Data Science totalmente funcional e automatizada na AWS, capaz de fornecer insights valiosos sobre o comportamento de compra dos clientes, apoiando assim decisões estratégicas de negócios e marketing


## 1) Instruções do Lab 4
### 1.1) Criação de imgem e container com mapeamento de volume
__Importante:__ \
Execute localmente o script cria_modelo.py para gerar o arquivo pkl, que é o "modelo treinado" como parte do lab, antes de efetuar o deploy na AWS.


Abra o terminal ou prompt de comando e navegue até a pasta onde você colocou os arquivos do Lab4 (não use espaço ou acento em nome de pasta)


Execute o comando abaixo para criar a imagem Docker:\
__docker build -t bamr-terraform-image:lab4 .__


Execute o comando abaixo para criar o container Docker:\
__docker run -dit --name bamr-lab4 -v ./IaC:/iac dsa-terraform-image:lab4 /bin/bash__

__NOTA:__ No Windows você deve substituir ./IaC pelo caminho completo da pasta, por exemplo: C:\xxx\Cap08\IaC

Verifique as versões do Terraform e do AWS CLI com os comandos abaixo

terraform version
aws --version

__ATENÇÃO:__ \
É NECESSÁRIO TER O ANACONDA PYTHON INSTALADO LOCALMENTE PARA FAZER O DEPLOY LOCAL.

### 1.2) Criação dos scripts terraform
- main.tf para criação dos recusros.
    - Recursos e ordem de criação: 
        - IAM Role → IAM Role Policy → IAM Instance Profile.
        - Security Group.
        - S3 Bucket.
        - EC2 Instance.
- variables.tf
- terraform.tfvars

### 1.3) Execução do lab
O arquivo upload_to_s3 copiará os arquivos da máquina local para o bucket. \
O comando "sudo aws s3 sync s3://${var.bucket_name} /bamr_ml_app" do arquivo main.tf efetuará a sincronização do bucket na instância EC2.

Após a exceução do "terraform apply" valide ser os recusros foram criados. \
Acesse a instância EC2, via console (connect):
- cd /
- ls -la (para verificar se a pasta bamr_ml_app foi criada na instância)
- ps -ax | grep python 
- Quando aparecer a mensagem "/usr/bin/python3 /usr/local/bin/gunicorn -w 4 -b 0.0.0.0:5000 app:app", significa que o deploy foi realizado com sucesso.
- No browser acesse http://<Public IPv4 DNS>:5000 e execute o modelo, implementado na cloud AWS.

