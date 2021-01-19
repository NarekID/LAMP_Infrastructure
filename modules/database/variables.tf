variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "database_sg_id" {
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

variable "db_identifier" {
  type = string
}