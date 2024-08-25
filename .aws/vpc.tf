resource "aws_vpc" "fullcycle-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

data "aws_availability_zones" "aws-availability-zones" {}

resource "aws_subnet" "fullcycle-subnets" {
  count = 2
  availability_zone = data.aws_availability_zones.aws-availability-zones.names[count.index]
  vpc_id = aws_vpc.fullcycle-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "fullcycle-igw" {
  vpc_id = aws_vpc.fullcycle-vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "fullcycle-rtb" {
  vpc_id = aws_vpc.fullcycle-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fullcycle-igw.id
  }
  tags = {
    Name = "${var.prefix}-rtb"
  }
}

resource "aws_route_table_association" "fullcycle-rtb-associations" {
  count = 2
  route_table_id = aws_route_table.fullcycle-rtb.id
  subnet_id = aws_subnet.fullcycle-subnets.*.id[count.index]
}