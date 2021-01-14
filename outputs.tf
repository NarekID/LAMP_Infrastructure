//output "WebServer_Address" {
//  value = aws_instance.notejam_webserver.public_dns
//}

output "alb_dns_name" {
  value = aws_lb.notejam_alb.dns_name
}

output "alb_route53_record" {
  value = aws_route53_record.app_record.name
}