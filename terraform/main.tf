provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./modules/network"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
}

module "compute" {
  source = "./modules/compute"
  ami_id = "ami-12345678"
  instance_type = "t2.micro"
  user_data = file("user_data.sh")
  instance_security_group = module.network.instance_security_group
  min_size = 1
  max_size = 3
  desired_capacity = 2
  subnet_ids = module.network.private_subnet_ids
}