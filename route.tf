data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.testvpc.id}"

  tags {
    Name = "Terraform ${terraform.workspace} IGW"
  }
}

resource "aws_network_acl" "nacl" {
  vpc_id = "${aws_vpc.testvpc.id}"

  ingress {
    cidr_block = "0.0.0.0/0"
    action     = "allow"
    protocol   = "-1"
    rule_no    = 101
    from_port  = 0
    to_port    = 0
  }

  egress {
    cidr_block = "0.0.0.0/0"
    action     = "allow"
    rule_no    = 102
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "${terraform.workspace} ACL"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.testvpc.id}"

  tags {
    Name = "${terraform.workspace} Public RT"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

resource "aws_eip" "Nat" {
  vpc = true
}

resource "aws_nat_gateway" "PublicAZA" {
  allocation_id = "${aws_eip.Nat.id}"
  subnet_id     = "${aws_subnet.PublicAZA.id}"
  depends_on    = ["aws_internet_gateway.igw"]
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.testvpc.id}"

  tags {
    Name = "${terraform.workspace} Private RT"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.PublicAZA.id}"
  }
}
