### **Projeto 2 - Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR**  

### ⚠️ **IMPORTANTE: Este projeto gera cobrança na AWS**

O **Projeto 2** tem como objetivo a implementação e deploy de um **stack avançado de treinamento distribuído de Machine Learning** utilizando **PySpark** no **Amazon Elastic MapReduce (EMR)**. A proposta é otimizar o processamento distribuído para treinar modelos em larga escala, reduzindo o tempo de treinamento e maximizando o uso de recursos.  

A estrutura do projeto inclui a **configuração de um cluster EMR**, projetado para **execução eficiente de tarefas de Machine Learning distribuídas**. A solução é escalável e resiliente, aproveitando os serviços da AWS para **gerenciamento de recursos e monitoramento**. O **deploy automatizado** e a **integração contínua** são garantidos por scripts e templates de **Infraestrutura como Código (IaC)**, assegurando **replicabilidade e consistência do ambiente**.  

Além do aspecto técnico, o projeto adota **melhores práticas de Ciência de Dados**, cobrindo desde **preparação de dados** até **seleção e avaliação de modelos** em um contexto distribuído. A solução desenvolvida permite o treinamento eficiente de modelos em **grandes volumes de dados (escala petabyte)**, sendo ideal para organizações que buscam **insights profundos a partir de Big Data**.  

Os dados utilizados no projeto foram preparados com base no conjunto de dados disponível em:  
🔗 [Stanford Sentiment Dataset](https://ai.stanford.edu/~amaas/data/sentiment) 🚀


## **1. Recursos Terraform Utilizados no Projeto**

### **1.1. Segurança e Rede**  
- `aws_security_group`  
  - **main_security_group** (Grupo de segurança principal)  
  - **core_security_group** (Grupo de segurança para os nós do cluster)  

### **1.2. Cluster EMR**  
- `aws_emr_cluster`  
  - **cluster** (Provisionamento do cluster no AWS EMR)  

### **1.3. Gerenciamento de Identidade e Acesso (IAM)**  
- `aws_iam_role`  
  - **iam_emr_service_role** (Papel IAM para o serviço EMR)  
  - **iam_emr_profile_role** (Papel IAM para instâncias EC2 no cluster)  
- `aws_iam_instance_profile`  
  - **emr_profile** (Perfil de instância associado ao cluster EMR)  

### **1.4. Armazenamento S3**  
- `aws_s3_bucket`  
  - **create_bucket** (Bucket S3 para armazenamento dos dados do projeto)  
- `aws_s3_bucket_versioning`  
  - **versioning_bucket** (Configuração de versionamento para o bucket)  
- `aws_s3_bucket_public_access_block`  
  - **example** (Bloqueio de acesso público ao bucket S3)  

#### **1.4.1. Armazenamento S3**  
Este projeto utiliza um recurso de seguranção do terraform para utilização de scripts python que serão utilzados nesse projeto e serão enviados para o bucket-s3.
O bucket-s3 onde os scripts python ficarão armazenados será destruído ao final deste projeto.

#### **`filemd5` no Terraform - Explicação Detalhada**
A função **`filemd5`** no Terraform é usada para calcular o **hash MD5** do conteúdo de um arquivo. O MD5 (Message Digest Algorithm 5) é um algoritmo de hash criptográfico que gera um valor de 128 bits (32 caracteres hexadecimais) a partir de uma entrada, permitindo verificar alterações no conteúdo de um arquivo.

---

#### **1.4.1.1.📌 Sintaxe da Função**
```hcl
filemd5(path)
```
- **`path`**: Caminho do arquivo no sistema de arquivos local.
- Retorna uma **string hexadecimal** representando o hash MD5 do conteúdo do arquivo.

---

#### **1.4.1.2.📌 Exemplo Básico**
Se tivermos um arquivo chamado `config.yaml`, podemos calcular seu hash MD5 da seguinte maneira:

```hcl
output "config_md5" {
  value = filemd5("config.yaml")
}
```
#### **1.4.1.3. Saída esperada no Terraform Apply:**
```bash
config_md5 = "d41d8cd98f00b204e9800998ecf8427e"
```
Este hash muda sempre que o conteúdo do arquivo `config.yaml` é alterado.

---

#### **1.4.1.2. 📌 Para que serve `filemd5` no Terraform?**
#### **1.4.1.2.1. Detectar mudanças em arquivos**
Se um arquivo for modificado, seu hash MD5 também será alterado. Isso pode ser útil para:
- Identificar alterações de arquivos de configuração.
- Criar regras para acionar a recriação de recursos no Terraform.

---

#### **1.4.1.2.1.2. Forçar a recriação de recursos quando um arquivo muda**
O Terraform pode não detectar mudanças em arquivos usados em um recurso. Podemos usar `filemd5` dentro da opção **`triggers`** de um recurso para forçar sua atualização quando o arquivo for alterado.

#### **Exemplo: Forçando atualização de um servidor quando um script muda**
```hcl
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  user_data = file("setup.sh")

  lifecycle {
    ignore_changes = [user_data]
  }

  triggers = {
    script_hash = filemd5("setup.sh")
  }
}
```
**O que acontece aqui?**
- O Terraform calculará o hash MD5 do arquivo `setup.sh`.
- Se o conteúdo de `setup.sh` mudar, o hash também muda.
- Isso faz com que o recurso **`aws_instance.example`** seja recriado automaticamente.

---

#### **1.4.1.3. Comparação de arquivos para controle de versões**
Podemos comparar o hash de dois arquivos diferentes para verificar se possuem o mesmo conteúdo.

```hcl
output "comparison" {
  value = filemd5("config_old.yaml") == filemd5("config_new.yaml")
}
```
Se os arquivos forem idênticos, o output será `true`, caso contrário, `false`.

---

#### **1.4.1.4.📌 Limitações**
1. **Apenas arquivos locais**: `filemd5` só pode ser usado em arquivos armazenados localmente no ambiente onde o Terraform está sendo executado.
2. **Não detecta mudanças em arquivos remotos**: Se o arquivo estiver em um S3 ou GitHub, `filemd5` não funcionará diretamente.
3. **MD5 não é seguro para criptografia**: Embora seja útil para detectar mudanças, o MD5 não deve ser usado para fins de segurança (exemplo: armazenamento de senhas).

---

#### **1.4.1.5.📌 Alternativas e Complementos**
- **`filesha256("file.txt")`** → Se precisar de um hash mais seguro, use SHA-256 em vez de MD5.
- **`file("arquivo.txt")`** → Para obter o conteúdo de um arquivo como string.

---

#### **1.4.1.6.📌 Conclusão**
A função **`filemd5`** é muito útil no Terraform para rastrear mudanças em arquivos e garantir que recursos sejam atualizados quando necessário. Usando essa função de forma estratégica, é possível melhorar a automação e a confiabilidade da infraestrutura.

## **2. Este projeto utilizará armazenamento de dados em formatp parquet**
#### **2.1.📌 Por que usar arquivos Parquet para armazenamento de dados?**

O **Parquet** é um formato de armazenamento de dados amplamente utilizado em sistemas de Big Data por suas vantagens de desempenho e eficiência. Ele foi projetado para processamento analítico e otimizado para leitura rápida e compactação eficiente.

#### **2.2.🔹 Principais Benefícios do Parquet**

#### 🚀 1. Alto Desempenho na Leitura
- Formato **colunar**, permitindo leitura seletiva de colunas, reduzindo I/O.
- Ideal para **consultas analíticas** e **agregações**.

#### 📉 2. Melhor Compressão e Eficiência de Armazenamento
- **Compressão eficiente** por colunas (Snappy, Gzip, ZSTD).
- **Menos espaço em disco** comparado a CSV e JSON.

#### ⚡ 3. Suporte a Tipagem e Esquema Rígido
- **Mantém tipos de dados** (inteiros, floats, strings, etc.).
- **Evita parsing e conversões desnecessárias**, tornando a leitura mais rápida.

#### 🔄 4. Integração com Ferramentas de Big Data
- Compatível com **Apache Spark, Hive, Presto, AWS Athena, Google BigQuery**, entre outros.
- Ideal para **Data Lakes** e processamento distribuído.

#### 🛠 5. Melhor Manuseio de Dados Estruturados
- **Suporte a metadados e partições**.
- Permite leitura eficiente mesmo em **grandes volumes de dados**.

#### **2.3. 🎯 Quando Usar o Parquet?**
✅ Data Lakes e **armazenamento eficiente em cloud** (AWS S3, GCS, Azure).  
✅ Consultas analíticas e **Big Data**.  
✅ Redução de custos com **armazenamento e processamento**.  
✅ Integração com **ferramentas de BI e Machine Learning**.  

#### **2.4.🏁 Conclusão**
O formato **Parquet** oferece **melhor desempenho, menor custo de armazenamento e integração perfeita com ferramentas de Big Data**. Se você trabalha com **grandes volumes de dados**, esse é o formato ideal para otimizar seu fluxo de trabalho.



## **3. Como executar este projeto** 


### 3.1. Configuração Inicial

1. Abra o terminal ou prompt de comando.
2. Navegue até a pasta onde você colocou os arquivos do projeto.
   - **Nota:** Evite usar espaços ou acentos no nome das pastas.

### 3.2. Construção da Imagem Docker

Execute o comando abaixo para criar a imagem Docker:
```sh
docker build -t bamr-terraform-image:projeto2 .
```

### 3.3. Criação do Container Docker

Execute o comando abaixo para criar o container Docker:
```sh
docker run -dit --name bamr-p2 -v ./IaC:/iac bamr-terraform-image:p2 /bin/bash
```

**Nota:** No Windows, substitua `./IaC` pelo caminho completo da pasta. Exemplo:

### 3.4. Verificação das Versões

Verifique se o Terraform e o AWS CLI estão instalados corretamente com os seguintes comandos:
```sh
terraform version
aws --version
```

---

## Configuração do Projeto

### 1. Editar Arquivos de Configuração

- Edite os arquivos `config.tf` e `terraform.tfvars` e insira seu **ID da AWS** onde indicado.
- No script `projeto2.py`, adicione seu **ID da AWS** e suas **chaves AWS** onde indicado.

### 2. Criar Bucket S3 Manualmente

Antes de executar o Terraform, crie manualmente o bucket S3 com o nome:
```sh
bamr-dsa-p2-terraform-<id-aws>
```
**Substitua `<id-aws>` pelo seu ID da AWS.** \
**bamr-dsa-p2-terraform é apenas a sugestão do meu projeto.**

### 3. Inicialização e Deploy do Terraform

Execute os seguintes comandos:
```sh
terraform init
terraform apply
```

### 4. Monitoramento do Pipeline

- Acompanhe a execução do pipeline pela **interface da AWS**, conforme demonstrado nas aulas.

---

## Conclusão

Parabéns! Você configurou e implantou o ambiente com sucesso. 🚀


