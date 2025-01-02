output  "vpc_name" {
  value = var.vpc_name
}
output  "vpc_id" {
  value = aws_vpc.default.id
  
}
output  "environment" {
  value = var.environment
} 
output "public-subnets" {
  value = aws_subnet.public-subnet.*.id
}
output "private-subnets" {
  value = aws_subnet.private-subnet.*.id
}
output "public-subnets-id-1" {
  value = "${aws_subnet.public-subnet.0.id}"
}
