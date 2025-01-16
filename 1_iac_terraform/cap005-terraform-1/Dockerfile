# Imagem oficial do Ubuntu
FROM ubuntu:latest

# Mantenedor da imagem
LABEL maintainer="BAMR"

# Atualização de pacotes e dependedências necessárias
RUN apt-get update && apt-get install -y bash && \
    apt-get install -y wget unzip curl

# Definição da versão do Terraform
ENV TERRAFORM_VERSION=1.6.4

# Downloado e instação do Terraform
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Criação da pasta lab2 no container
RUN mkdir /lab2

# Copia a parta local para a pasta lab2 no container
COPY tarefa1/ /lab2/tarefa1/

# Criação da pasta Downloads para instalação do AWS CLI (acesso a AWS)
RUN mkdir Downloads && \
    cd Downloads && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Comando padrão para execução, quando o container for iniciado
CMD ["/bin/bash"]

