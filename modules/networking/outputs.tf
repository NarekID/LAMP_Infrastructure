output "vpc_id" {
  value = aws_vpc.webapp_vpc.id
}

output "public_subnets" {
  value = aws_subnet.public_subnet
}

output "public_subnets_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "private_subnets" {
  value = aws_subnet.private_subnet
}

output "private_subnets_ids" {
  value = aws_subnet.private_subnet.*.id
}

output "webserver_sg_id" {
  value = aws_security_group.webserver_sg.id
}

output "database_sg_id" {
  value = aws_security_group.database_sg.id
}

output "lb_sg_id" {
  value = aws_security_group.lb_sg.id
}