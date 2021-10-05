// create internet gateway, allow public subnet to access the Internet
resource "aws_internet_gateway" "igw" {
  vpc_id = var.is_custom ? aws_vpc.vpc.id : 0

  tags = {
    name = "${var.project}-igw"
  }
}

// create public subnets, every availability zone has one subnet to achieve high availability
resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidr)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr[count.index]
  availability_zone = var.az[count.index]

  tags = {
    name = "${var.project}-public-subnet-${count.index}"
  }
}

// create public route table, every availability zone has one route table
resource "aws_route_table" "public_route_table" {
  count   = length(var.az)
  vpc_id  = aws_vpc.vpc.id
}

// attach route table to subnet
resource "aws_route_table_association" "public_route_table_association" {
  count           = length(var.public_subnet_cidr)

  subnet_id       = aws_subnet.public_subnet[count.index].id
  route_table_id  = aws_route_table.public_route_table[count.index].id
}

// add routing rules in route table
resource "aws_route" "public-route" {
  count                   = var.is_custom ? 0 : length(var.az)
  route_table_id          = aws_route_table.public_route_table[count.index].id
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = var.is_custom ? var.igw_id : aws_internet_gateway.igw.id
}

