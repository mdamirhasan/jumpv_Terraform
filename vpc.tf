resource "aws_vpc" "jumpv" {
  cidr_block = "10.0.0.0/16"


  tags = {
    Name = "jumpv"
  }
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.jumpv.id

  tags = {
    Name = "jumpv-rt"
  }
}

#locals {
#  s3_origin_id = "BVR-S3-bucket"
#}

resource "aws_subnet" "us-east-1a" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.jumpv.id
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "us-east-1b" {
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = aws_vpc.jumpv.id
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "us-east-1c" {
  cidr_block              = "10.0.3.0/24"
  vpc_id                  = aws_vpc.jumpv.id
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = "true"
}

