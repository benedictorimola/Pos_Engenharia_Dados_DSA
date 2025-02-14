# Imagem oficial do Ubuntu
FROM ubuntu:latest

# Mantenedor
LABEL maintainer="BAMR"

# Atualização de pacotes e inetalação de dependências
RUN apt-get update && \
    apt-get install -y wget unzip curl openssh-client iputils-ping

# Definição de versão do terraform
ENV TERRAFORM_VERSION=1.6.4

# Instalação do Terraform
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Criação de pasta como ponto para montagem de volume
RUN mkdir /projeto_1_lab3
VOLUME /projeto_1_lab3

# Criar a pasta Downloads e instalar o AWS CLI (para acessar a AWS)
RUN mkdir Downloads && \
    cd Downloads && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Definir o comando padrão para execução quando o container for iniciado
CMD ["/bin/bash"]
