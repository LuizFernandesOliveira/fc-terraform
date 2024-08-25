resource "aws_vpc" "vpc-fullcycle" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-fullcycle"
  }
}