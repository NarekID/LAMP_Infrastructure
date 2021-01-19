resource "aws_db_subnet_group" "db_subnet_group" {
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "database" {
  identifier             = "notejam-database"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.20"
  name                   = var.db_name
  username               = var.db_admin_user
  password               = var.db_admin_password
  parameter_group_name   = "default.mysql8.0"
  option_group_name      = "default:mysql-8-0"
  vpc_security_group_ids = [var.database_sg_id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
}