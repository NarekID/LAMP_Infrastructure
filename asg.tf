data "aws_ami" "notejam_ami_latest" {
  owners      = ["self"]
  name_regex  = "ubuntu20-notejam-*"
  most_recent = true
}

resource "aws_key_pair" "key_pair" {
  key_name   = "lab-key1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/8yMOyvDjPA3uIJ3aDuOSo1V7TgvLLOvSnAkC275+l2CNoCdUETrf8IB8ro741TCk9MT5PUoyiExXxmNEESaAGjb/W/DpSzJ8zZSUHMJHYfaeo2sMxh3J5iIpRael8j06EK5PZOUVNyd5rWGsusobszVDq00mt4VtanyyrNIyzgKJCfWFBqxOK3J0Fo8GcRa1r8vns3N+nmTiiN62BJaUDntKpKSz6mI2JStm1APDGa6QsoO2PmRGep+vtGGEY7MC/pYiSe2mMkrTg/KaTySeNFpwekPv6Zxfcncqd1i0XNkWabmhwC7Gw0yg0khaK/y6jEdKOwRIN78LghdLIHvD"
}

resource "aws_launch_template" "notejam_lt" {
  name                   = "notejam-lt"
  description            = "notejam launch template"
  instance_type          = "t3.micro"
  image_id               = data.aws_ami.notejam_ami_latest.id
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  ebs_optimized          = true
  user_data              = filebase64("user_data.sh")
  iam_instance_profile {
    name = aws_iam_instance_profile.rds_full_access.name
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
      Name = "Notejam-WebServer"
    }
  }

}

resource "aws_autoscaling_group" "notejam_asg" {
  name              = "notejam-autoscaling-group"
  health_check_type = "ELB"
  //  load_balancers = [aws_lb.notejam_alb.name]
  target_group_arns = [aws_lb_target_group.notejam_alb_tg.arn]
  max_size          = 2
  min_size          = 2
  desired_capacity  = 2

  launch_template {
    id      = aws_launch_template.notejam_lt.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    aws_default_subnet.subnet1.id,
    aws_default_subnet.subnet2.id
  ]

  depends_on = [aws_db_instance.notejam_db, aws_lb.notejam_alb]
}