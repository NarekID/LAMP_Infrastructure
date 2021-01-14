resource "aws_security_group" "webserver_sg" {
  name        = "WebServer-SG"
  description = "WebServer-SG"

  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = [var.external_ip]
  }
  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "database_sg" {
  name        = "Database-SG"
  description = "Database-SG"

  ingress {
    from_port = 3306
    protocol  = "tcp"
    to_port   = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }
}