# Imagem oficial do ubuntu
FROM ubuntu:latest

# Mantenedor
LABEL maintainer="BAMR"

# Atualização de pacotes do sistema e instalação de dependências
RUN apt-get update && \
    apt-get install -y wget unzip curl openssh-client iputils-ping git

# Definição de versão do terraform
ENV TERRAFORM_VERSION=1.6.6

# Baixar e instalar Terraform
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Criar pasta como ponto de montagem do volume
RUN mkdir /iac
VOLUME /iac


# Criar a pasta Downloads e instalar o AWS CLI (para acessar a AWS)
RUN mkdir Downloads && \
    cd Downloads && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Definir o comando padrão para execução quando o container for iniciado
CMD ["/bin/bash"]