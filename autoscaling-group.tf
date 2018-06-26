resource "aws_autoscaling_group" "web" {
  launch_configuration = "${aws_launch_configuration.web.id}"

  //availability_zones = ["${data.aws_availability_zones.available.names[0]}"]
  vpc_zone_identifier = ["${aws_subnet.PublicAZA.*.id}"]
  min_size            = 1
  max_size            = "${lookup(var.max_instance_count, terraform.workspace)}"
  enabled_metrics     = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
  load_balancers      = ["${aws_elb.web.name}"]
  health_check_type   = "ELB"

  tag {
    key                 = "Name"
    value               = "${terraform.workspace}-terraform-web"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "autopolicy_web" {
  name                   = "${terraform.workspace}-web-autopolicy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.web.name}"
}

resource "aws_cloudwatch_metric_alarm" "web-cpualarm" {
  alarm_name          = "${terraform.workspace}-web-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.web.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.autopolicy_web.arn}"]
}

resource "aws_autoscaling_policy" "web-autopolicy-down" {
  name                   = "${terraform.workspace}-web-autopolicy-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.web.name}"
}

resource "aws_cloudwatch_metric_alarm" "web-cpualarm-down" {
  alarm_name          = "${terraform.workspace}-web-alarm-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.web.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.web-autopolicy-down.arn}"]
}

resource "aws_autoscaling_group" "app" {
  launch_configuration = "${aws_launch_configuration.app.id}"

  //availability_zones = ["${data.aws_availability_zones.available.names[0]}"]
  vpc_zone_identifier = ["${aws_subnet.PublicAZA.*.id}"]
  min_size            = 1
  max_size            = "${lookup(var.max_instance_count, terraform.workspace)}"
  enabled_metrics     = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
  load_balancers      = ["${aws_elb.app.name}"]
  health_check_type   = "ELB"

  tag {
    key                 = "Name"
    value               = "${terraform.workspace}-terraform-app"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "autopolicy_app" {
  name                   = "${terraform.workspace}-app-autopolicy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.app.name}"
}

resource "aws_cloudwatch_metric_alarm" "app-cpualarm" {
  alarm_name          = "${terraform.workspace}-app-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.app.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.autopolicy_app.arn}"]
}

resource "aws_autoscaling_policy" "app-autopolicy-down" {
  name                   = "${terraform.workspace}-app-autopolicy-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.app.name}"
}

resource "aws_cloudwatch_metric_alarm" "app-cpualarm-down" {
  alarm_name          = "${terraform.workspace}-app-alarm-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.app.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.app-autopolicy-down.arn}"]
}
