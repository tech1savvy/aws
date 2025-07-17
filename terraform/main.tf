provider "aws" {
  region = "ap-south-1"
}

# Define project-wide variables
locals {
  project_name           = "key-sensei"
  vpc_cidr               = "10.0.0.0/27"
  public_a_cidr          = "10.0.0.0/28"
  public_b_cidr          = "10.0.0.16/28"
  az_a                   = "ap-south-1a"
  az_b                   = "ap-south-1b"
  app_port               = 80
  ssh_cidr               = "0.0.0.0/0" # IMPORTANT: Change this to your specific IP for security
  ami_id                 = "ami-0a1235697f4afa8a4"
  instance_type          = "t2.micro"
  key_name               = "aws-first-key"
  min_size               = 2
  max_size               = 3
  desired_capacity       = 2
  cpu_utilization_target = 20.0
}

module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = local.vpc_cidr
  project_name = local.project_name
}

module "subnets" {
  source        = "./modules/subnets"
  vpc_id        = module.vpc.vpc_id
  public_a_cidr = local.public_a_cidr
  public_b_cidr = local.public_b_cidr
  az_a          = local.az_a
  az_b          = local.az_b
  project_name  = local.project_name
}

module "internet_gateway" {
  source       = "./modules/internet_gateway"
  vpc_id       = module.vpc.vpc_id
  project_name = local.project_name
}

module "route_tables" {
  source              = "./modules/route_tables"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  public_subnet_a_id  = module.subnets.public_subnet_a_id
  public_subnet_b_id  = module.subnets.public_subnet_b_id
  project_name        = local.project_name
}

module "alb_security_group" {
  source       = "./modules/alb_security_group"
  vpc_id       = module.vpc.vpc_id
  project_name = local.project_name
}

module "ec2_security_group" {
  source       = "./modules/ec2_security_group"
  vpc_id       = module.vpc.vpc_id
  alb_sg_id    = module.alb_security_group.alb_sg_id
  ssh_cidr     = local.ssh_cidr
  project_name = local.project_name
}

module "load_balancer" {
  source             = "./modules/load_balancer"
  vpc_id             = module.vpc.vpc_id
  alb_sg_id          = module.alb_security_group.alb_sg_id
  public_subnet_a_id = module.subnets.public_subnet_a_id
  public_subnet_b_id = module.subnets.public_subnet_b_id
  app_port           = local.app_port
}

module "launch_template" {
  source        = "./modules/launch_template"
  project_name  = local.project_name
  ami_id        = local.ami_id
  instance_type = local.instance_type
  key_name      = local.key_name
  ec2_sg_id     = module.ec2_security_group.ec2_sg_id
}

module "autoscaling_group" {
  source                 = "./modules/autoscaling_group"
  project_name           = local.project_name
  min_size               = local.min_size
  max_size               = local.max_size
  desired_capacity       = local.desired_capacity
  public_subnet_ids      = module.subnets.public_subnet_ids
  lb_target_group_arn    = module.load_balancer.lb_target_group_arn
  launch_template_id     = module.launch_template.launch_template_id
  cpu_utilization_target = local.cpu_utilization_target
}
