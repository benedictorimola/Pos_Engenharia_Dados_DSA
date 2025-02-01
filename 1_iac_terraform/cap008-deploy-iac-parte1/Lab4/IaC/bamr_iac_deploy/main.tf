provider "aws" {
    region = var.region
  
}

# Criação de IAM Role
resource "aws_iam_role" "ec2_s3_access_role" {
    name = var.iam_role_name
    assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  
}

# Criação de IAM Role Policy
resource "aws_iam_role_policy" "ec2_s3_access_policy" {
    name = var.iam_role_policy_name
    role = aws_iam_role.ec2_s3_access_role.id
      policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Effect = "Allow",
        Resource = [
          "${aws_s3_bucket.bamr_bucket_flask.arn}/*",
          "${aws_s3_bucket.bamr_bucket_flask.arn}"
        ]
      },
    ]
  })
  
}

# Criação de IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_s3_profile" {
    name = var.iam_instance_profile_name
    role = aws_iam_role.ec2_s3_access_role.name
  
}

# Criação do security group
resource "aws_security_group" "sg_bamr_ml_api" {
    name = var.security_group_name

  ingress {
    description = "Inbound Rule 1"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Inbound Rule 2"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Inbound Rule 3"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound Rule"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

# Criação do bucket
resource "aws_s3_bucket" "bamr_bucket_flask" {
    bucket = var.bucket_name

    tags = {
        Name = var.tag_bucket
        Environment = "Lab 4"
    }

    provisioner "local-exec" {
        command = "${path.module}/upload_to_s3.sh"
      
    }

    provisioner "local-exec" {
        when = destroy
        command = "aws s3 rm s3://${self.bucket} --recursive"
      
    }
  
}

# criação de instancia EC2
resource "aws_instance" "bamr_ml_api" {

  ami = var.ami_name

  instance_type = var.instance_type_name

  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name

  vpc_security_group_ids = [aws_security_group.sg_bamr_ml_api.id]

  # Script de inicialização
  # sudo aws s3 sync s3://dsa-bamr-767397908248-bucket /bamr_ml_app
  # No comando acima, todo conteúdo da pasta S3 será copiado para o EC2
  # gunicorn is a Python WSGI HTTP Server for UNIX. 
  # Não é aconselhavel usar Flask em produção para alto volume.
  # gunicorn -w 4 -b 0.0.0.0:5000 app:app &
  # gunicorn é o comando, após o pacote gunicorn ser instalado
  # -w 4 é a quantidade de workers.  NO caso, 4
  # -b 0.0.0.0:5000 será usada a porta 5000 para execução 
  # app tipo de execução 
  #:app é o nome da app a ser executada.  Nesse exemplo app.py é o nome da app
  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y python3 python3-pip awscli
                sudo pip3 install flask joblib scikit-learn numpy scipy gunicorn
                sudo mkdir /bamr_ml_app
                sudo aws s3 sync s3://${var.bucket_name} /bamr_ml_app
                cd /bamr_ml_app
                nohup gunicorn -w 4 -b 0.0.0.0:5000 app:app &
              EOF


  tags = {
    Name = "BAMRFlaskApp"
  }
}