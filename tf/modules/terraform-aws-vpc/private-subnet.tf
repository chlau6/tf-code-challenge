resource "aws_eip" "ip" {
  count = length(var.private_subnet) > 0 ? 1 : 0
  vpc   = true
}

# create nat gateway to allow private subnet to have access to the Internet, multiple private subnet will use the same nat gateway
resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.private_subnet) > 0 ? 1 : 0
  allocation_id = aws_eip.ip[0].id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  tags = {
    Name = "${var.project}-nat-gw"
  }
}

# create private subnets
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = lookup(var.private_subnet[count.index], "cidr")
  availability_zone = lookup(var.private_subnet[count.index], "availability_zone")

  tags = {
    Name = "${var.project}-private-subnet-${count.index}"
  }
}

# create private route table, multiple private subnets will use the same route table
resource "aws_route_table" "private_route_table" {
  vpc_id  = aws_vpc.vpc.id
}

# attach the route table to private subnet
resource "aws_route_table_association" "private_route_table_association" {
  count           = length(var.private_subnet)

  subnet_id       = aws_subnet.private_subnet[count.index].id
  route_table_id  = aws_route_table.private_route_table.id
}

# add routing rules in route table
resource "aws_route" "private-route" {
  count                   = var.is_custom && var.nat_gw_id == "" ? 0 : 1
  route_table_id          = aws_route_table.private_route_table.id
  destination_cidr_block  = "0.0.0.0/0"
  nat_gateway_id          = var.is_custom ? var.nat_gw_id : aws_nat_gateway.nat_gateway[0].id
}
