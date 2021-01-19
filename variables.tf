variable "domain_name" {
  type    = string
  default = "cmcloudlab1776.info."
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "igw_name" {
  type = string
}

variable "public_cidrs" {
  type = list(string)
}

variable "public_subnet_name" {
  type = string
}

variable "private_cidrs" {
  type = list(string)
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
  type = string
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