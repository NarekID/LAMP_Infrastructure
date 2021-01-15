variable "domain_name" {
  type    = string
  default = "cmcloudlab631.info."
}

variable "webserver_port" {
  type    = number
  default = 80
}

variable "external_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "db_name" {
  type    = string
  default = "notejam_db"
}

variable "db_admin_user" {
  type    = string
  default = "admin"
}

variable "db_user_password" {
  type    = string
  default = "Password123"
}