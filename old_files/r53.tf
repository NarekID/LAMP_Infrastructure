//data "aws_route53_zone" "dns" {
//  name = var.domain_name
//}
//
//resource "aws_route53_record" "db_record" {
//  zone_id = data.aws_route53_zone.dns.id
//  name    = join(".", ["database", data.aws_route53_zone.dns.name])
//  type    = "CNAME"
//  records = [module.database.db_address]
//  ttl     = 300
//}
//
//resource "aws_route53_record" "app_record" {
//  zone_id = data.aws_route53_zone.dns.id
//  name    = join(".", ["notejam", data.aws_route53_zone.dns.name])
//  type    = "A"
//  alias {
//    evaluate_target_health = true
//    name                   = module.computing.lb_dns_name
//    zone_id                = module.computing.lb_zone_id
//  }
//}