output "WebServer_Address" {
  value = aws_instance.notejam_webserver.public_dns
}