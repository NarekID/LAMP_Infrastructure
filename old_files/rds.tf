//resource "time_static" "timestamp" {}
//
//resource "aws_db_subnet_group" "db_subnet_group" {
//  subnet_ids = module.networking.private_subnets.*.id
//}
//
//resource "aws_db_instance" "notejam_db" {
//  identifier             = "notejam-database"
//  instance_class         = "db.t2.micro"
//  allocated_storage      = 20
//  storage_type           = "gp2"
//  engine                 = "mysql"
//  engine_version         = "8.0.20"
//  name                   = var.db_name
//  username               = var.db_admin_user
//  password               = var.db_user_password
//  parameter_group_name   = "default.mysql8.0"
//  option_group_name      = "default:mysql-8-0"
//  vpc_security_group_ids = [aws_security_group.database_sg.id]
//  publicly_accessible    = false
//  skip_final_snapshot    = true
//  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
//  //  final_snapshot_identifier = "notejam-db-snapshot-${time_static.timestamp.unix}"
//}