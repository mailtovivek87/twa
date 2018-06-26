resource "aws_route53_zone" "r53" {
  name = "${terraform.workspace}.mytwassignment.com"
}

resource "aws_route53_record" "app_route53_record" {
  zone_id = "${aws_route53_zone.r53.zone_id}"
  name    = "app.${terraform.workspace}.mytwassignment.com"
  type    = "A"

  alias {
    name                   = "${aws_elb.app.dns_name}"
    zone_id                = "${aws_elb.app.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "web_route53_record" {
  zone_id = "${aws_route53_zone.r53.zone_id}"
  name    = "web.${terraform.workspace}.mytwassignment.com"
  type    = "A"

  alias {
    name                   = "${aws_elb.web.dns_name}"
    zone_id                = "${aws_elb.web.zone_id}"
    evaluate_target_health = true
  }
}
