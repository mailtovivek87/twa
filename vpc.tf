provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

resource "aws_vpc" "testvpc" {
  cidr_block           = "${var.vpc-cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${terraform.workspace}-VPC"
  }
}
