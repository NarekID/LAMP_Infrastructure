data "aws_availability_zones" "available" {}

resource "aws_vpc" "webapp_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.webapp_vpc.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_cidrs)
  cidr_block              = element(var.public_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.webapp_vpc.id

  tags = {
    Name = "${var.public_subnet_name}-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count                   = length(var.private_cidrs)
  cidr_block              = element(var.private_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.webapp_vpc.id

  tags = {
    Name = "${var.private_subnet_name}-${count.index + 1}"
  }
}

resource "aws_eip" "nat_gw" {
  vpc = true

  tags = {
    Name = var.eip_name
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)

  tags = {
    Name = var.nat_gw_name
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.webapp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = var.public_rt_name
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.webapp_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = var.private_rt_name
  }
}

//resource "aws_route_table_association" "public_rt_assoc" {
//  route_table_id = aws_route_table.public_rt.id
//  for_each = toset(aws_subnet.public_subnet.*.id)
//  subnet_id = each.key
//}
//
//resource "aws_route_table_association" "private_rt_assoc" {
//  route_table_id = aws_route_table.private_rt.id
//  for_each = toset(aws_subnet.private_subnet.*.id)
//  subnet_id = each.key
//}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(aws_subnet.public_subnet)
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
}

resource "aws_route_table_association" "private_rt_assoc" {
  count          = length(aws_subnet.private_subnet)
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
}

resource "aws_default_route_table" "default_rt" {
  default_route_table_id = aws_vpc.webapp_vpc.default_route_table_id

  tags = {
    Name = var.default_rt_name
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "Application-LB-SG"
  description = "Application-LB-SG"
  vpc_id      = aws_vpc.webapp_vpc.id

  ingress {
    from_port   = var.webserver_port
    protocol    = "tcp"
    to_port     = var.webserver_port
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "webserver_sg" {
  name        = "WebServer-SG"
  description = "WebServer-SG"
  vpc_id      = aws_vpc.webapp_vpc.id

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [var.external_ip]
  }
  ingress {
    from_port       = var.webserver_port
    protocol        = "tcp"
    to_port         = var.webserver_port
    security_groups = [aws_security_group.lb_sg.id]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "database_sg" {
  name        = "Database-SG"
  description = "Database-SG"
  vpc_id      = aws_vpc.webapp_vpc.id

  ingress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    security_groups = [aws_security_group.webserver_sg.id]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}