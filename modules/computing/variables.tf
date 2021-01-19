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

variable "ami_name_regex" {
  type = string
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