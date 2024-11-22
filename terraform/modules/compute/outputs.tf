output "lb_dns_name" {
  value = aws_lb.app_lb.dns_name
}

output "route53_record" {
  value = aws_route53_record.app_record.fqdn
}

output "cloudwatch_alarm" {
  value = aws_cloudwatch_metric_alarm.cpu_alarm.alarm_arn
}

