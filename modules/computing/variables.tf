variable "vpc_id" {
  type = string
}

variable "webserver_port" {
  type = number
}

variable "external_ip" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_key" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "server_name" {
  type = string
}

variable "lb_sg_id" {
  type = string
}

variable "webserver_sg_id" {
  type = string
}