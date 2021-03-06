vpc_cidr = {
  prod = "10.0.0.0/16",
  test = "192.168.0.0/16"
}
public_cidrs = {
  prod = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ],
  test = [
    "192.168.1.0/24",
    "192.168.2.0/24"
  ]
}
private_cidrs = {
  prod = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ],
  test = [
    "192.168.11.0/24",
    "192.168.12.0/24"
  ]
}
vpc_name            = "WebApp-VPC"
igw_name            = "WebApp-IGW"
public_subnet_name  = "Public-Subnet"
private_subnet_name = "Private-Subnet"
eip_name            = "WebApp-NAT-IP"
nat_gw_name         = "WebApp-NAT-GW"
public_rt_name      = "Public-RT"
private_rt_name     = "Private-RT"
default_rt_name     = "Default-RT"
policy_arn          = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
role_name           = "RDS-FullAccess"
public_key = {
  prod = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/8yMOyvDjPA3uIJ3aDuOSo1V7TgvLLOvSnAkC275+l2CNoCdUETrf8IB8ro741TCk9MT5PUoyiExXxmNEESaAGjb/W/DpSzJ8zZSUHMJHYfaeo2sMxh3J5iIpRael8j06EK5PZOUVNyd5rWGsusobszVDq00mt4VtanyyrNIyzgKJCfWFBqxOK3J0Fo8GcRa1r8vns3N+nmTiiN62BJaUDntKpKSz6mI2JStm1APDGa6QsoO2PmRGep+vtGGEY7MC/pYiSe2mMkrTg/KaTySeNFpwekPv6Zxfcncqd1i0XNkWabmhwC7Gw0yg0khaK/y6jEdKOwRIN78LghdLIHvD",
  test = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/8yMOyvDjPA3uIJ3aDuOSo1V7TgvLLOvSnAkC275+l2CNoCdUETrf8IB8ro741TCk9MT5PUoyiExXxmNEESaAGjb/W/DpSzJ8zZSUHMJHYfaeo2sMxh3J5iIpRael8j06EK5PZOUVNyd5rWGsusobszVDq00mt4VtanyyrNIyzgKJCfWFBqxOK3J0Fo8GcRa1r8vns3N+nmTiiN62BJaUDntKpKSz6mI2JStm1APDGa6QsoO2PmRGep+vtGGEY7MC/pYiSe2mMkrTg/KaTySeNFpwekPv6Zxfcncqd1i0XNkWabmhwC7Gw0yg0khaK/y6jEdKOwRIN78LghdLIHvD"
}
external_ip    = "0.0.0.0/0"
webserver_port = 80
server_name    = "Notejam-WebServer"
webserver_dns_prefix = {
  prod = "notejam",
  test = "notejam-test"
}
database_dns_prefix = {
  prod = "database",
  test = "database-test"
}
db_identifier = {
  prod = "notejam-database",
  test = "notejam-test-database"
}
ami_name_regex = {
  prod = "ubuntu20-notejam-",
  test = "ubuntu20-notejam-test-"
}
lt_name  = "launch-template"
alb_name = "application-lb"
tg_name  = "target-group"
asg_name = "autoscaling-group"
kp_name  = "key_pair"

// Secrets
db_name           = "notejam_db"
db_admin_user     = "admin"
db_admin_password = "Password123"