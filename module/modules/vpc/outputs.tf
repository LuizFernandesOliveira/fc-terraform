output "vpc_id" {
  value = aws_vpc.fullcycle-vpc.id
}

output "subnet_ids" {
  value = aws_subnet.fullcycle-subnets[*].id
}