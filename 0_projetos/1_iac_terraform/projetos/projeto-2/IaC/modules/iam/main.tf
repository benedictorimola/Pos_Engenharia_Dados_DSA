# Projeto 2 - Deploy do Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR
# Configuração dos recursos IAM

# IAM role para EMR Service
resource "aws_iam_role" "iam_emr_service_role" {

  name = "iam_emr_service_role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticmapreduce.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Anexando política à EMR Service Role
resource "aws_iam_role_policy_attachment" "emr_service_role_policy" {
  role       = aws_iam_role.iam_emr_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
}

# IAM Role para EC2 Instance Profile
resource "aws_iam_role" "iam_emr_profile_role" {
  
  name = "iam_emr_profile_role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Anexando política à EMR Profile Role
resource "aws_iam_role_policy_attachment" "emr_profile_role_policy" {
  role       = aws_iam_role.iam_emr_profile_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"
}

# Profile
resource "aws_iam_instance_profile" "emr_profile" {
  name = "emr_profile"
  role = aws_iam_role.iam_emr_profile_role.name
}
