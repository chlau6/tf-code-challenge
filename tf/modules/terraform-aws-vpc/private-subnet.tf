resource "aws_eip" "ip" {
  count = var.is_custom ? length(var.az) : 0
  vpc   = true
}

// create nat gateway, every availability zone has one nat gateway, allow private subnet to have access to the Internet
resource "aws_nat_gateway" "nat_gateway" {
  count         = var.is_custom ? length(var.az) : 0
  allocation_id = aws_eip.ip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  tags = {
    name = "${var.project}-nat-gw"
  }
}

// create private subnets, every availability zone has one subnet to achieve high availability
resource "aws_subnet" "private_subnet" {
  count             = length(var.public_subnet_cidr)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr[count.index]
  availability_zone = var.az[count.index]

  tags = {
    name = "${var.project}-private-subnet-${count.index}"
  }
}

// create private route table, every subnet has one route table
resource "aws_route_table" "private_route_table" {
  count   = length(var.az)
  vpc_id  = aws_vpc.vpc.id
}

// associate route table to private subnet
resource "aws_route_table_association" "private_route_table_association" {
  count           = length(var.az)

  subnet_id       = aws_subnet.private_subnet[count.index].id
  route_table_id  = aws_route_table.private_route_table[count.index].id
}

// add routing rules in route table
resource "aws_route" "private-route" {
  count                   = var.is_custom ? 0 : length(var.az)
  route_table_id          = aws_route_table.private_route_table[count.index].id
  destination_cidr_block  = "0.0.0.0/0"
  nat_gateway_id          = var.is_custom ? var.nat_gw_id : aws_nat_gateway.nat_gateway.id
}