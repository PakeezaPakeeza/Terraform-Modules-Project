module "prod_ec2_1" {
  source      = "../modules/compute"
  environment = module.prod_vpc_1.environment
  amis = {
    us-east-1 = "ami-0866a3c8686eaeeba"
    us-east-2 = "ami-0ea3c35c5c3284d82"
    }
  aws_region      = var.aws_region
  instance_type        = "t2.micro"
  key_name        = "n.virginia-key"
  public-subnets  = module.prod_vpc_1.public-subnets
  private-subnets = module.prod_vpc_1.private-subnets
  sg_id           = module.prod_sg_1.sg_id
  vpc_name        = module.prod_vpc_1.vpc_name
  #elb_listener        = module.prod_elb_1.elb_listner
  elb_listener_public  = module.prod_elb_1_public.elb_listner # module.module-name.output-name
  iam_instance_profile = module.prod_iam_1.instprofile
}
# #just to chcek the count value of public server
# output "prod_public_server_count" {
#   description = "Public server count from the compute module"
#   value       = module.prod_ec2_1.public_server_count
# }
# #just to chcek the environment 
# output "prod_environment_debug" {
#   description = "Environment debug output from the compute module"
#   value       = module.prod_ec2_1.environment_debug
# }
# module "prod_elb_1" {
#   source          = "../modules/elb"
#   environment     = module.prod_vpc_1.environment
#   nlbname         = "dev-nlb"
#   subnets         = module.prod_vpc_1.public-subnets
#   tgname          = "dev-nlb-tg-private"
#   vpc_id          = module.prod_vpc_1.vpc_id
#   private_servers = module.prod_ec2_1.private_servers
# }
module "prod_elb_1_public" {
  source          = "../modules/elb"
  environment     = module.prod_vpc_1.environment
  nlbname         = "prod-nlb-public"
  subnets         = module.prod_vpc_1.public-subnets
  tgname          = "prod-nlb-tg-public"
  vpc_id          = module.prod_vpc_1.vpc_id
  private_servers = module.prod_ec2_1.public_servers
}
module "prod_iam_1" {
  source              = "../modules/iam"
  environment         = module.prod_vpc_1.environment
  rolename            = "SaiTMRole"
  instanceprofilename = "SaiTMinstprofile"
}