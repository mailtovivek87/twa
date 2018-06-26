resource "aws_subnet" "PublicAZA" {
  vpc_id     = "${aws_vpc.testvpc.id}"
  cidr_block = "${var.public-subnet-cidr}"

  tags {
    Name = "${terraform.workspace}-PublicAZA"
  }

  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
}

resource "aws_route_table_association" "PublicAZA" {
  subnet_id      = "${aws_subnet.PublicAZA.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_subnet" "PrivateAZA" {
  vpc_id     = "${aws_vpc.testvpc.id}"
  cidr_block = "${var.private-subnet-cidr}"

  tags {
    Name = "${terraform.workspace}-PublicAZB"
  }

  availability_zone = "${data.aws_availability_zones.available.names[1]}"
}

resource "aws_route_table_association" "PrivateAZA" {
  subnet_id      = "${aws_subnet.PrivateAZA.id}"
  route_table_id = "${aws_route_table.private.id}"
}
