resource "aws_subnet" "public-subnet" {
  #count             = 3 #012
  count             = length(var.public_cidr_block)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.public_cidr_block, count.index + 1)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name        = "${var.vpc_name}-public-subnet-${count.index + 1}"
    Owner       = local.Owner
    costcenter  = local.costcenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"

  }
}