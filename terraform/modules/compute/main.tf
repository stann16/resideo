provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_launch_configuration" "app" {
  image_id        = var.ami_id
  instance_type   = var.instance_type
  user_data       = var.user_data
  security_groups = [var.instance_security_group]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.app.id
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = var.subnet_ids

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}

resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_security_group]
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "app_tg" {
  name = "app-tg"
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_route53_record" "app_record" {
  zone_id = var.route53_zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_lb.app_lb.dns_name
    zone_id                = aws_lb.app_lb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "cpu_alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.cloudwatch_alarm_threshold
  alarm_description   = "Alarm when CPU exceeds threshold"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
}

output "lb_dns_name" {
  value = aws_lb.app_lb.dns_name
}

output "route53_record" {
  value = aws_route53_record.app_record.fqdn
}

output "cloudwatch_alarm" {
  value = aws_cloudwatch_metric_alarm.cpu_alarm.alarm_arn
}