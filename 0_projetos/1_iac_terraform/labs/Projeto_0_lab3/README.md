# 1) Projeto: criação de servidor web na AWS sem uso de provisioner
### 1.1 Definição


 1-O servidor web deve ter 3 réplicas (ou seja, de fato serão 3 instâncias EC2 criadas em um único projeto Terraform). Use a camada gratuita com o tipo de instância t2.micro. 
 
 2- Cada servidor web deve ter uma página HTML diferente identificando o servidor. Uma linha de código como esta é suficiente: "Bem-vindo ao Server 1"
 
 3-Um  loop  no  arquivo  main.tf  deve  criar  as  3  instâncias  EC2  de  forma  automatizada. 

  
 
 Aqui estão os links de referência na documentação oficial: \
 [For expressions](https://developer.hashicorp.com/terraform/language/expressions/for) \
[Conditional expressions](https://developer.hashicorp.com/terraform/language/expressions/conditionals)

# 2) Criação de Container
- Criação de imagem  
Navegue até o diretório local onde está localizado o Dockerfile e execute o comando de criação da imagem. \
__docker build -t bam3-terraform-image:projeto_1_lab3 .__

- Criação de container \
__docker run -dit --name projeto_1_lab3 -v ./DIR_LOCAL:/lab3 bam3-terraform-image:projeto_1_lab3 /bin/bash__

__NOTA 1:__ \
No Windows você deve substituir __./DIR_LOCAL__ pelo caminho completo da pasta, por exemplo: __C:\xxx\Cap07\Lab3__

__NOTA 2:__ \
O comando abaixo permite o mapeamento de volume em diretótio local.  Dessa forma, qualquer alteração na máquina local será automaticamente repletida no container e vice-versa. \
__-v ./DIR_LOCAL:/lab3 bam3-terraform-image:projeto_1_lab3 /bin/bash__

