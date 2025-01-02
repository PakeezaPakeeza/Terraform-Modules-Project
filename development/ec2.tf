module "dev_ec2_1" {
  source      = "../modules/compute"
  environment = "module.dev_vpc_1.environment"
  amis = {
    us-east-1 = "ami-0866a3c8686eaeeba"
    us-east-2 = "ami-0ea3c35c5c3284d82"
  }
  aws_region      = var.aws_region
  instance_type        = "t2.micro"
  key_name        = "n.virginia-key"
  public-subnets  = module.dev_vpc_1.public-subnets
  private-subnets = module.dev_vpc_1.private-subnets
  sg_id           = module.dev_sg_1.sg_id
  vpc_name        = module.dev_vpc_1.vpc_name
  #elb_listener         = module.dev_elb_1.elb_listner
  elb_listener_public  = module.dev_elb_1_public.elb_listner # module.module-name.output-name
  iam_instance_profile = module.dev_iam_1.instprofile
}

# module "dev_elb_1" {
#   source          = "../modules/elb"
#   environment     = module.dev_vpc_1.environment
#   nlbname         = "dev-nlb"
#   subnets         = module.dev_vpc_1.public-subnets
#   tgname          = "dev-nlb-tg-private"
#   vpc_id          = module.dev_vpc_1.vpc_id
#   private_servers = module.dev_ec2_1.private_servers
# }
module "dev_elb_1_public" {
  source          = "../modules/elb"
  environment     = module.dev_vpc_1.environment
  nlbname         = "dev-nlb-public"
  subnets         = module.dev_vpc_1.public-subnets
  tgname          = "dev-nlb-tg-public"
  vpc_id          = module.dev_vpc_1.vpc_id
  private_servers = module.dev_ec2_1.public_servers
}
module "dev_iam_1" {
  source              = "../modules/iam"
  environment         = module.dev_vpc_1.environment
  rolename            = "SaiTMRole"
  instanceprofilename = "SaiTMinstprofile"
}