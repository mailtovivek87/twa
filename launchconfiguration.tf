resource "aws_launch_configuration" "web" {
  name            = "web"
  image_id        = "${lookup(var.amis,var.region)}"
  instance_type   = "${lookup(var.instance_type, terraform.workspace)}"
  security_groups = ["${aws_security_group.tfsg.id}"]
  key_name        = "${var.ssh-key}"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install apache2 unzip -y
              wget https://s3.amazonaws.com/infra-assessment/static.zip
              unzip static.zip
              mv static /var/www/html/
              sudo service apache2 start
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "app" {
  name            = "app"
  image_id        = "${lookup(var.amis,var.region)}"
  instance_type   = "${lookup(var.instance_type, terraform.workspace)}"
  security_groups = ["${aws_security_group.tfsg.id}"]
  key_name        = "${var.ssh-key}"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              apt-get install tomcat7 -y
              wget https://s3.amazonaws.com/infra-assessment/companyNews.war
              mv companyNews.war /var/lib/tomcat7/webapps/
              mkdir -p /Users/dcameron/persistence/files
              sudo chown -R tomcat7:tomcat7 /Users/
              rm -rf /var/lib/tomcat7/webapps/ROOT
              sudo service tomcat7 restart
              EOF

  lifecycle {
    create_before_destroy = true
  }
}
