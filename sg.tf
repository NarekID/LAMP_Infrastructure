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