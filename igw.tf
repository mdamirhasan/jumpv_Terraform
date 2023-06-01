resource "aws_internet_gateway" "jumpv" {
  vpc_id = aws_vpc.jumpv.id

  tags = {
    Name = "Internet-Gateway"
  }
}

resource "aws_route_table" "jumpv" {
  vpc_id = aws_vpc.jumpv.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jumpv.id
  }
}

resource "aws_route_table_association" "jumpv" {
  subnet_id      = aws_subnet.us-east-1a.id
  route_table_id = aws_route_table.jumpv.id
}

resource "aws_route_table_association" "jumpv1" {
  subnet_id      = aws_subnet.us-east-1b.id
  route_table_id = aws_route_table.jumpv.id
}

resource "aws_route_table_association" "jumpv2" {
  subnet_id      = aws_subnet.us-east-1c.id
  route_table_id = aws_route_table.jumpv.id
}
