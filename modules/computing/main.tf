resource "aws_lb" "app_lb" {
  name               = "application-lb"
  load_balancer_type = "application"
  internal           = false
  subnets            = var.public_subnets
  security_groups    = [var.lb_sg_id]
}

resource "aws_lb_target_group" "alb_tg" {
  name        = "target-group"
  port        = var.webserver_port
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    enabled  = true
    protocol = "HTTP"
    path     = "/"
    port     = var.webserver_port
    interval = 10
    matcher  = "300-399"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = var.webserver_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

data "aws_ami" "latest_ami" {
  owners      = ["self"]
  name_regex  = "ubuntu20-notejam-*"
  most_recent = true
}

resource "aws_key_pair" "key_pair" {
  key_name   = "lab-key1"
  public_key = var.public_key
}

resource "aws_launch_template" "lt" {
  name                   = "Launch-template"
  description            = "Launch template"
  instance_type          = "t3.micro"
  image_id               = data.aws_ami.latest_ami.id
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [var.webserver_sg_id]
  ebs_optimized          = true
  user_data              = filebase64("${path.module}/user_data.sh")

  iam_instance_profile {
    name = var.instance_profile_name
  }

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = 8
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.server_name
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  name              = "notejam-autoscaling-group"
  health_check_type = "ELB"
  target_group_arns = [aws_lb_target_group.alb_tg.arn]
  max_size          = 2
  min_size          = 2
  desired_capacity  = 2

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  vpc_zone_identifier = var.private_subnets

  depends_on = [aws_lb.app_lb]
}