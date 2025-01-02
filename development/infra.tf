#root module where you run terraform init, terraform plan, and terraform apply
module "dev_vpc_1" {
  source             = "../modules/network"
  vpc_cidr           = "10.0.0.0/16"
  vpc_name           = "dev_vpc_1"
  environment        = "Development"
  public_cidr_block  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_cidr_block = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
  azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
  natgw_id           = module.dev_natgw_1.natgw_id
}
#use/call of security group module
module "dev_sg_1" {
  source        = "../modules/sg"
  vpc_name      = module.dev_vpc_1.vpc_name #vpc_name and vpc_id are outputs defined in the vpc module. is module.dev_vpc mein jao or or output value ly k ao called vpc_name       
  vpc_id        = module.dev_vpc_1.vpc_id   #passes the VPC ID (output from the VPC module) to the security group module #module.<module_name>.<output_name>
  ingress_value = ["80", "8080", "443", "8443", "22", "3306", "1900", "1443"]
  environment   = module.dev_vpc_1.environment
}

module "dev_natgw_1" {
  source           = "../modules/nat"
  public-subnets-id = module.dev_vpc_1.public-subnets-id-1
  vpc_name         = module.dev_vpc_1.vpc_name
}
