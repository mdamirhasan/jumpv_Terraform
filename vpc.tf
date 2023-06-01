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

resource "aws_security_group" "jumpv" {
  name_prefix = "jumpv-sg"
  vpc_id      = aws_vpc.jumpv.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTPS connections"
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming myqsl connections"
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





