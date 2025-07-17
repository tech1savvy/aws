provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "load_balancer" {
  source               = "./modules/load_balancer"
  vpc_id               = module.vpc.vpc_id
  alb_sg_id            = module.security.alb_sg_id
  public_subnet_a_id   = module.vpc.public_subnet_a_id
  public_subnet_b_id   = module.vpc.public_subnet_b_id
}

module "ec2_instance" {
  source                = "./modules/ec2_instance"
  ec2_sg_id             = module.security.ec2_sg_id
  public_subnet_a_id    = module.vpc.public_subnet_a_id
  public_subnet_b_id    = module.vpc.public_subnet_b_id
  lb_target_group_arn   = module.load_balancer.lb_target_group_arn
}