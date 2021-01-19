//data "aws_ami" "notejam_ami_latest" {
//  owners      = ["self"]
//  name_regex  = "ubuntu20-notejam-*"
//  most_recent = true
//}
//
//resource "aws_key_pair" "key_pair" {
//  key_name   = "lab-key1"
//  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/8yMOyvDjPA3uIJ3aDuOSo1V7TgvLLOvSnAkC275+l2CNoCdUETrf8IB8ro741TCk9MT5PUoyiExXxmNEESaAGjb/W/DpSzJ8zZSUHMJHYfaeo2sMxh3J5iIpRael8j06EK5PZOUVNyd5rWGsusobszVDq00mt4VtanyyrNIyzgKJCfWFBqxOK3J0Fo8GcRa1r8vns3N+nmTiiN62BJaUDntKpKSz6mI2JStm1APDGa6QsoO2PmRGep+vtGGEY7MC/pYiSe2mMkrTg/KaTySeNFpwekPv6Zxfcncqd1i0XNkWabmhwC7Gw0yg0khaK/y6jEdKOwRIN78LghdLIHvD"
//}
//
//resource "aws_instance" "notejam_webserver" {
//  ami                         = data.aws_ami.notejam_ami_latest.id
//  instance_type               = "t2.micro"
//  vpc_security_group_ids      = [aws_security_group.webserver_sg.id]
//  associate_public_ip_address = true
//  iam_instance_profile        = aws_iam_instance_profile.rds_full_access.name
//  key_name                    = aws_key_pair.key_pair.key_name
//  user_data                   = file("user_data.sh")
//
//  tags = {
//    Name = "Notejam-WebServer"
//  }
//
//  depends_on = [aws_db_instance.notejam_db]
//}
