//data "aws_availability_zones" "available" {}
//
//resource "aws_default_vpc" "default_vpc" {}
//
//resource "aws_default_subnet" "subnet1" {
//  availability_zone = data.aws_availability_zones.available.names[0]
//}
//
//resource "aws_default_subnet" "subnet2" {
//  availability_zone = data.aws_availability_zones.available.names[1]
//}
//
//resource "aws_vpc" "webapp_vpc" {
//  cidr_block = "10.0.0.0/16"
//
//  tags = {
//    Name = "WebApp-VPC"
//  }
//}
//
//resource "aws_internet_gateway" "main_igw" {
//  vpc_id = aws_vpc.webapp_vpc.id
//
//  tags = {
//    Name = "WebApp-IGW"
//  }
//}
//
//resource "aws_subnet" "public_subnet" {
//  count                   = 2
//  cidr_block              = "10.0.${count.index + 1}.0/24"
//  availability_zone       = data.aws_availability_zones.available.names[count.index]
//  map_public_ip_on_launch = true
//  vpc_id                  = aws_vpc.webapp_vpc.id
//
//  tags = {
//    Name = "Public-Subnet-${count.index + 1}"
//  }
//}
//
//resource "aws_subnet" "private_subnet" {
//  count                   = 2
//  cidr_block              = "10.0.1${count.index + 1}.0/24"
//  availability_zone       = data.aws_availability_zones.available.names[count.index]
//  map_public_ip_on_launch = false
//  vpc_id                  = aws_vpc.webapp_vpc.id
//
//  tags = {
//    Name = "Private-Subnet-${count.index + 1}"
//  }
//}
//
//resource "aws_eip" "nat_gw" {
//  vpc = true
//
//  tags = {
//    Name = "WebApp-NAT-IP"
//  }
//}
//
//resource "aws_nat_gateway" "nat_gw" {
//  allocation_id = aws_eip.nat_gw.id
//  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
//
//  tags = {
//    Name = "WebApp-NAT-GW"
//  }
//}
//
//resource "aws_route_table" "public_rt" {
//  vpc_id = aws_vpc.webapp_vpc.id
//
//  route {
//    cidr_block = "0.0.0.0/0"
//    gateway_id = aws_internet_gateway.main_igw.id
//  }
//
//  tags = {
//    Name = "Public-RT"
//  }
//}
//
//resource "aws_route_table" "private_rt" {
//  vpc_id = aws_vpc.webapp_vpc.id
//
//  route {
//    cidr_block     = "0.0.0.0/0"
//    nat_gateway_id = aws_nat_gateway.nat_gw.id
//  }
//
//  tags = {
//    Name = "Private-RT"
//  }
//}
//
//resource "aws_route_table_association" "public_rt_assoc" {
//  count          = length(aws_subnet.public_subnet)
//  route_table_id = aws_route_table.public_rt.id
//  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
//}
//
//resource "aws_route_table_association" "private_rt_assoc" {
//  count          = length(aws_subnet.private_subnet)
//  route_table_id = aws_route_table.private_rt.id
//  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
//}
//
//resource "aws_default_route_table" "default_rt" {
//  default_route_table_id = aws_vpc.webapp_vpc.default_route_table_id
//
//  tags = {
//    Name = "Default-RT"
//  }
//}
