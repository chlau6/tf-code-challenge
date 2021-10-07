# create internet gateway, allow public subnet to access the Internet
resource "aws_internet_gateway" "igw" {
  count         = length(var.public_subnet) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-igw"
  }
}

# create public subnets
resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = lookup(var.public_subnet[count.index], "cidr")
  availability_zone = lookup(var.public_subnet[count.index], "availability_zone")

  tags = {
    Name = "${var.project}-public-subnet-${count.index}"
  }
}

# create public route table, multiple public subnets will use the same route table
resource "aws_route_table" "public_route_table" {
  vpc_id  = aws_vpc.vpc.id
}

# attach the route table to subnets
resource "aws_route_table_association" "public_route_table_association" {
  count           = length(var.public_subnet)

  subnet_id       = aws_subnet.public_subnet[count.index].id
  route_table_id  = aws_route_table.public_route_table.id
}

# add routing rules in route table
resource "aws_route" "public-route" {
  count                   = var.is_custom && var.igw_id == "" ? 0 : 1
  route_table_id          = aws_route_table.public_route_table.id
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = var.is_custom ? var.igw_id : aws_internet_gateway.igw[0].id
}

