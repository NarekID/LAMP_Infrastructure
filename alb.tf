resource "aws_default_vpc" "default_vpc" {}

resource "aws_lb" "notejam_alb" {
  name               = "notejam-application-lb"
  load_balancer_type = "application"
  internal           = false
  subnets = [
    data.aws_subnet.subnet1.id,
    data.aws_subnet.subnet2.id
  ]
  security_groups = [aws_security_group.webserver_sg.id]

}

resource "aws_lb_target_group" "notejam_alb_tg" {
  name        = "notejam-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_default_vpc.default_vpc.id
  health_check {
    enabled  = true
    protocol = "HTTP"
    path     = "/"
    port     = 80
    interval = 10
    matcher  = "200-299"
  }
}

resource "aws_lb_listener" "notejam_alb_listener" {
  load_balancer_arn = aws_lb.notejam_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.notejam_alb_tg.arn
  }
}