resource "aws_eip" "ip" {
  count = length(var.private_subnet) > 0 ? 1 : 0
  vpc   = true
}

// create nat gateway, every availability zone has one nat gateway, allow private subnet to have access to the Internet
resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.private_subnet) > 0 ? 1 : 0
  allocation_id = aws_eip.ip.id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  tags = {
    name = "${var.project}-nat-gw"
  }
}

// create private subnets, every availability zone has one subnet to achieve high availability
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = lookup(var.private_subnet[count.index], "cidr")
  availability_zone = lookup(var.private_subnet[count.index], "availability_zone")

  tags = {
    name = "${var.project}-private-subnet-${count.index}"
  }
}

// create private route table, every subnet has one route table
resource "aws_route_table" "private_route_table" {
  vpc_id  = aws_vpc.vpc.id
}

// associate route table to private subnet
resource "aws_route_table_association" "private_route_table_association" {
  subnet_id       = aws_subnet.private_subnet[count.index].id
  route_table_id  = aws_route_table.private_route_table.id
}

// add routing rules in route table
resource "aws_route" "private-route" {
  count                   = var.is_custom && var.nat_gw_id == "" ? 0 : 1
  route_table_id          = aws_route_table.private_route_table.id
  destination_cidr_block  = "0.0.0.0/0"
  nat_gateway_id          = var.is_custom ? var.nat_gw_id : aws_nat_gateway.nat_gateway.id
}