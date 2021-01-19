provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source              = "./modules/networking"
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  igw_name            = var.igw_name
  public_cidrs        = var.public_cidrs
  public_subnet_name  = var.public_subnet_name
  private_cidrs       = var.private_cidrs
  private_subnet_name = var.private_subnet_name
  eip_name            = var.eip_name
  nat_gw_name         = var.nat_gw_name
  public_rt_name      = var.public_rt_name
  private_rt_name     = var.private_rt_name
  default_rt_name     = var.default_rt_name
  external_ip         = var.external_ip
  webserver_port      = var.webserver_port
}

module "ec2_role" {
  source     = "./modules/ec2_role"
  policy_arn = var.policy_arn
  role_name  = var.role_name
}

module "computing" {
  source                = "./modules/computing"
  vpc_id                = module.networking.vpc_id
  webserver_port        = var.webserver_port
  external_ip           = var.external_ip
  public_subnets        = module.networking.public_subnets_ids
  private_subnets       = module.networking.private_subnets_ids
  public_key            = var.public_key
  instance_profile_name = module.ec2_role.role_name
  server_name           = var.server_name
  lb_sg_id              = module.networking.lb_sg_id
  webserver_sg_id       = module.networking.webserver_sg_id
  depends_on            = [module.database, module.networking]
}

module "database" {
  source            = "./modules/database"
  vpc_id            = module.networking.vpc_id
  private_subnets   = module.networking.private_subnets_ids
  db_name           = var.db_name
  db_admin_user     = var.db_admin_user
  db_admin_password = var.db_admin_password
  depends_on        = [module.networking]
  database_sg_id    = module.networking.database_sg_id
}

module "dns" {
  source      = "./modules/dns"
  domain_name = var.domain_name
  db_address  = module.database.db_address
  lb_dns_name = module.computing.lb_dns_name
  lb_zone_id  = module.computing.lb_zone_id
}