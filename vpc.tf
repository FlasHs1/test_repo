resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_internet_gateway" "default_igw" {
  vpc_id = aws_default_vpc.default_vpc.id
}

resource "aws_route_table" "default_rt" {
  vpc_id = aws_default_vpc.default_vpc.id

  dynamic "route" {
    for_each = var.route

    content {
      cidr_block     = "0.0.0.0/0"
      gateway_id     = aws_internet_gateway.default_igw.id
      instance_id    = null
      nat_gateway_id = null
    }
  }
}

resource "aws_route_table_association" "default_ta" {
  count          = length(var.subnet_ids)

  subnet_id      = element(var.subnet_ids, count.index)
  route_table_id = aws_route_table.default_rt.id
}
