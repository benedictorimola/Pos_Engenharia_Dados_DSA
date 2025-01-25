module "bamr_ec2_instances" {
    source = "./modules/ec2_instances"
    instance_count = 3
    ami_id = "ami-08970251d20e940b0"
    instance_type = "t2.micro"
    subnet_id = "subnet-0348194b7f1092edc"
}

module "bamr_s3_bucket" {
    source = "./modules/s3_bucket"
    bucket_name = "bamr-rimola-benedicto-bucket-lab2"
    tags = {"DSA" = "Pos Engenharia de dados"}
  
}