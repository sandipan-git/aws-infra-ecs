### Network

# Internet VPC
resource "aws_vpc" "aws-dev-vpc" {
  cidr_block           = "172.21.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "aws-dev-vpc"
  }
}

# Internet GW
resource "aws_internet_gateway" "aws-dev-gateway" {
  vpc_id = aws_vpc.aws-dev-vpc.id
  tags = {
    Name = "aws-dev-internet-gateway"
  }
}

# Subnets
resource "aws_subnet" "aws-dev-subnet-1" {
  vpc_id                  = aws_vpc.aws-dev-vpc.id
  cidr_block              = "172.21.10.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "aws-dev-subnet-1"
  }
}

resource "aws_subnet" "aws-dev-subnet-2" {
  vpc_id                  = aws_vpc.aws-dev-vpc.id
  cidr_block              = "172.21.20.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "aws-dev-subnet-1"
  }
}

# route tables
resource "aws_route_table" "aws-dev-route" {
  vpc_id = aws_vpc.aws-dev-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-dev-gateway.id
  }
  tags = {
    Name = "aws-dev-route"
  }
}

# route associations public
resource "aws_route_table_association" "aws-dev-public-1-a" {
  subnet_id      = aws_subnet.aws-dev-subnet-1.id
  route_table_id = aws_route_table.aws-dev-route.id
}

resource "aws_route_table_association" "aws-dev-public-2-a" {
  subnet_id      = aws_subnet.aws-dev-subnet-2.id
  route_table_id = aws_route_table.aws-dev-route.id
}
