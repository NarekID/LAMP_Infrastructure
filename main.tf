provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source              = "./modules/networking"
  vpc_cidr            = lookup(var.vpc_cidr, terraform.workspace)
  vpc_name            = "${terraform.workspace}-${var.vpc_name}"
  igw_name            = "${terraform.workspace}-${var.igw_name}"
  public_cidrs        = lookup(var.public_cidrs, terraform.workspace)
  public_subnet_name  = "${terraform.workspace}-${var.public_rt_name}"
  private_cidrs       = lookup(var.private_cidrs, terraform.workspace)
  private_subnet_name = "${terraform.workspace}-${var.private_rt_name}"
  eip_name            = "${terraform.workspace}-${var.eip_name}"
  nat_gw_name         = "${terraform.workspace}-${var.nat_gw_name}"
  public_rt_name      = "${terraform.workspace}-${var.public_rt_name}"
  private_rt_name     = "${terraform.workspace}-${var.private_rt_name}"
  default_rt_name     = "${terraform.workspace}-${var.default_rt_name}"
  external_ip         = var.external_ip
  webserver_port      = var.webserver_port
}

module "ec2_role" {
  source     = "./modules/ec2_role"
  policy_arn = var.policy_arn
  role_name  = "${terraform.workspace}-${var.role_name}"
}

module "computing" {
  source                = "./modules/computing"
  ami_name_regex        = lookup(var.ami_name_regex, terraform.workspace)
  lt_name               = "${terraform.workspace}-${var.lt_name}"
  alb_name              = "${terraform.workspace}-${var.alb_name}"
  tg_name               = "${terraform.workspace}-${var.tg_name}"
  asg_name              = "${terraform.workspace}-${var.asg_name}"
  vpc_id                = module.networking.vpc_id
  webserver_port        = var.webserver_port
  external_ip           = var.external_ip
  public_subnets        = module.networking.public_subnets_ids
  private_subnets       = module.networking.private_subnets_ids
  kp_name               = "${terraform.workspace}-${var.kp_name}"
  public_key            = lookup(var.public_key, terraform.workspace)
  instance_profile_name = module.ec2_role.role_name
  server_name           = "${terraform.workspace}-${var.server_name}"
  lb_sg_id              = module.networking.lb_sg_id
  webserver_sg_id       = module.networking.webserver_sg_id
  depends_on            = [module.database, module.networking]
}

module "database" {
  source            = "./modules/database"
  db_identifier     = lookup(var.db_identifier, terraform.workspace)
  vpc_id            = module.networking.vpc_id
  private_subnets   = module.networking.private_subnets_ids
  db_name           = var.db_name
  db_admin_user     = var.db_admin_user
  db_admin_password = var.db_admin_password
  depends_on        = [module.networking]
  database_sg_id    = module.networking.database_sg_id
}

module "dns" {
  source               = "./modules/dns"
  domain_name          = var.domain_name
  db_address           = module.database.db_address
  lb_dns_name          = module.computing.lb_dns_name
  lb_zone_id           = module.computing.lb_zone_id
  webserver_dns_prefix = lookup(var.webserver_dns_prefix, terraform.workspace)
  database_dns_prefix  = lookup(var.database_dns_prefix, terraform.workspace)
}