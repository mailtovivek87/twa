resource "aws_elb" "web" {
  name            = "${terraform.workspace}-elb-web"
  security_groups = ["${aws_security_group.elb.id}"]
  subnets         = ["${aws_subnet.PublicAZA.*.id}"]

  //availability_zones = ["${data.aws_availability_zones.available.names[1]}"]
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
}

resource "aws_elb" "app" {
  name            = "${terraform.workspace}-elb-app"
  security_groups = ["${aws_security_group.elb.id}"]
  subnets         = ["${aws_subnet.PublicAZA.*.id}"]

  //availability_zones = ["${data.aws_availability_zones.available.names[1]}"]
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "TCP:8080"
  }

  listener {
    lb_port           = 8080
    lb_protocol       = "tcp"
    instance_port     = "8080"
    instance_protocol = "tcp"
  }
}
