# Define VPC usando o módulo terraform-aws-modules/vpc/aws
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.4.0"

    # Nome da VPC e CIDR BLOCK
    name = "ecs-vpc"
    cidr = var.vpc_cidr_block

    # Zonas de disponibilidade e subnets
    azs = [var.az1, var.az2]
    public_subnets = [var.public_subnet_1, var.public_subnet_2]
    private_subnets = [var.private_subnet_1]

    # Tag para cada recurso na VPC
    private_subnet_tags         = { Name = "${var.project_name}-${var.env}-private-subnet" }
    public_subnet_tags          =  { Name = "${var.project_name}-${var.env}-public-subnet" }
    igw_tags                    = { Name = "${var.project_name}-${var.env}-igw" }
    default_security_group_tags = { Name = "${var.project_name}-${var.env}-default-sg" }
    default_route_table_tags    =  { Name = "${var.project_name}-${var.env}-rtb" }
    public_route_table_tags     =  { Name = "${var.project_name}-${var.env}-public_rtb" }
    
    # Tag da VPC
    tags = {
        Name = "${var.project_name}-${var.env}-vpc" 
    }
}
