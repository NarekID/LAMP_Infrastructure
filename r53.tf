data "aws_route53_zone" "dns" {
  name = var.domain_name
}

resource "aws_route53_record" "db_record" {
  zone_id = data.aws_route53_zone.dns.id
  name    = join(".", ["database", data.aws_route53_zone.dns.name])
  type    = "CNAME"
  records = [aws_db_instance.notejam_db.address]
  ttl     = 300
}