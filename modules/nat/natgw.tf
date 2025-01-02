resource "aws_eip" "natgw-eip" {
  domain = "vpc"
  tags = {
    Name        = "${var.vpc_name}-NAT-EIP"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw-eip.id
  subnet_id     = var.public-subnets-id

  tags = {
    Name = "${var.vpc_name}-NAT-GW"
  }
}