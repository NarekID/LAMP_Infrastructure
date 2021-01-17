resource "aws_lb" "notejam_alb" {
  name               = "notejam-application-lb"
  load_balancer_type = "application"
  internal           = false
  subnets            = aws_subnet.public_subnet.*.id
  security_groups    = [aws_security_group.lb_sg.id]

}

resource "aws_lb_target_group" "notejam_alb_tg" {
  name        = "notejam-target-group"
  port        = var.webserver_port
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.webapp_vpc.id
  health_check {
    enabled  = true
    protocol = "HTTP"
    path     = "/"
    port     = var.webserver_port
    interval = 10
    matcher  = "300-399"
  }
}

resource "aws_lb_listener" "notejam_alb_listener" {
  load_balancer_arn = aws_lb.notejam_alb.arn
  port              = var.webserver_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.notejam_alb_tg.arn
  }
}