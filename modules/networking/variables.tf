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

variable "external_ip" {
  type = string
}

variable "webserver_port" {
  type = number
}