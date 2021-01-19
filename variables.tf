variable "domain_name" {
  type    = string
  default = "cmcloudlab980.info."
}

variable "vpc_cidr" {
  type = map(any)
}

variable "vpc_name" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "public_cidrs" {
  type = map(any)
}

variable "public_subnet_name" {
  type = string
}

variable "private_cidrs" {
  type = map(any)
}

variable "private_subnet_name" {
  type = string
}

variable "eip_name" {
  type = string
}

variable "nat_gw_name" {
  type = string
}

variable "public_rt_name" {
  type = string
}

variable "private_rt_name" {
  type = string
}

variable "default_rt_name" {
  type = string
}

variable "policy_arn" {
  type = string
}

variable "role_name" {
  type = string
}

variable "webserver_port" {
  type = number
}

variable "external_ip" {
  type = string
}

variable "public_key" {
  type = map(any)
}

variable "server_name" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_admin_user" {
  type = string
}

variable "db_admin_password" {
  type = string
}

variable "webserver_dns_prefix" {
  type = map(any)
}

variable "database_dns_prefix" {
  type = map(any)
}

variable "db_identifier" {
  type = map(any)
}

variable "ami_name_regex" {
  type = map(any)
}

variable "lt_name" {
  type = string
}

variable "alb_name" {
  type = string
}

variable "tg_name" {
  type = string
}

variable "asg_name" {
  type = string
}

variable "kp_name" {
  type = string
}